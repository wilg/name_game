- view: cohorts
  derived_table:
    sql: |
      SELECT
        year, state, gender, 
        SUM(number) as number,
        row_number() OVER () as id
      FROM 
        {% if _dialect._name == 'bigquery' %}
          [fh-bigquery:popular_names.usa_1910_2013]
        {% else %}
        names
        {% endif %}
      GROUP BY 1,2,3
      
  fields:
  - dimension: id
    primary_key: true
  - dimension: year
    hidden: true
  - dimension: state
    hidden: true
  - dimension: gender
    hidden: true
  - dimension: number
    type:
    
  - measure: cohort_size
    type: sum
    sql: ${number}