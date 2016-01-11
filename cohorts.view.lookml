- view: cohorts
  derived_table:
    sql: |
      SELECT
        year, state, gender, SUM(number) as number
      FROM [fh-bigquery:popular_names.usa_1910_2013]
      GROUP BY 1,2,3
      
  fields:
  - dimension: year
    hidden: true
  - dimension: state
    hidden: true
  - dimension: gender
    hidden: true
  - dimension: number
    type: