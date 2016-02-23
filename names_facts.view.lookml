- explore: names_facts
- view: names_facts
  view_label: Names
  derived_table:
    sql: |
      SELECT * FROM (
      SELECT
        name
        , gender
        , first_year
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
      FROM (
        SELECT
          name
          , gender
          , year
          , first_year
          , cumlative_population
          , MAX(cumlative_population) OVER (PARTITION BY name, gender ORDER BY year DESC) as overall_population
        FROM (
          SELECT
            name
            , gender
            , year
            , MIN(year) OVER (PARTITION BY name, gender) as first_year
            , SUM(population) OVER (PARTITION BY name, gender ORDER BY year) as cumlative_population
          FROM (
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
          )
        )
      )
      GROUP BY 1,2,3,4
      )
      
  fields:
  - dimension: name
    hidden: true
  - dimension: gender
    hidden: true
    
  - dimension: first_year
    type: number
    value_format: "0000"
  
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

    