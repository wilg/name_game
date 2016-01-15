- view: cohorts
  derived_table:
    sql: |
      SELECT
        year, state, gender, 
        SUM(number) as number,
        row_number() OVER () as id
      FROM names
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