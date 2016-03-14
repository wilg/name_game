- explore: names_facts
  hidden: true
  
- explore: name_gender_year
  hidden: true
- view: name_gender_year
  derived_table:
    sql: |
        SELECT
          name
          , gender
          , year
          , SUM(number) as population
        FROM  {% if _dialect._name == 'bigquery' %}
                [fh-bigquery:popular_names.usa_1910_2013]
              {% else %}
                names
              {% endif %}
        GROUP BY 1,2,3
  fields:
  - dimension: name
  - dimension: gender
  - dimension: year
  - dimension: population
  

- explore: name_gender_year2
  hidden: true
- view: name_gender_year2
  derived_table:
    sql: |
      SELECT * FROM (
          SELECT
            name
            , gender
            , year
            , population
            , SUM(population) OVER (PARTITION BY name, gender ORDER BY year) as cumlative_population
          FROM ${name_gender_year.SQL_TABLE_NAME} 
      )
        
  fields:
  - dimension: name
  - dimension: gender
  - dimension: year
  - dimension: population
  - dimension: cumlative_population
  
- explore: name_gender_year3
  hidden: true
- view: name_gender_year3
  derived_table:
    sql: |
      SELECT * FROM (
          SELECT
            name
            , gender
            , year
            , population
            , cumlative_population
            , MAX(cumlative_population) OVER (PARTITION BY name, gender ORDER BY year DESC) as overall_population
          FROM ${name_gender_year2.SQL_TABLE_NAME} 
      )
        
  fields:
  - dimension: name
  - dimension: gender
  - dimension: year
  - dimension: population
  - dimension: cumlative_population
  - dimension: overall_population

- explore: name_median
  hidden: true
- view: name_median
  derived_table:
    sql: |
      SELECT * FROM (
      SELECT
        name
        , gender
        , MIN(
            CASE WHEN cumlative_population > overall_population *0.5
              THEN year
              ELSE null
              END ) as year_median
      FROM ${name_gender_year3.SQL_TABLE_NAME}
      GROUP BY 1,2
      )
  fields:
  - dimension: name
  - dimension: gender
  - dimension: year_median
 

- view: names_facts
  view_label: Names
  derived_table:
    sql: |
      SELECT * FROM (
      SELECT
        name
        , gender
        , overall_population
        , MIN(
            CASE WHEN cumlative_population > overall_population *0.5
              THEN year
              ELSE null
              END ) as year_median
        , MIN(
            CASE WHEN cumlative_population > overall_population *0.15
              THEN year
              ELSE null
              END ) as year_15_percent
        , MIN(
            CASE WHEN cumlative_population > overall_population *0.85
              THEN year
              ELSE null
              END ) as year_85_percent
        , RANK() OVER (PARTITION BY gender ORDER by overall_population DESC) as overall_rank
      FROM ${name_gender_year3.SQL_TABLE_NAME}
      GROUP BY 1,2,3
      )
      
  fields:
  - dimension: name
    hidden: true
  - dimension: gender
    hidden: true
    
  - dimension: overall_population
    type: number
  
  - dimension: year_median
    type: number
    value_format: "0000"
  
  - dimension: year_15_percent
    type: number
    value_format: "0000"
  
  - dimension: year_85_percent
    type: number
    value_format: "0000"
    
  - dimension: name_duration
    type: number
    sql: ${year_85_percent} - ${year_15_percent}

  - dimension: name_ramp
    type: number
    sql: ${year_median} - ${year_15_percent}

    
  - dimension: overall_rank
    type: number

    