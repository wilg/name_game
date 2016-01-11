- view: names
  sql_table_name: |
    [fh-bigquery:popular_names.usa_1910_2013]
    
  fields:
  - dimension: name
  - dimension: number
    type: number
  - dimension: state
  - dimension: year
    type: number
  - dimension: gender
  
  - measure: total_number
    type: sum
    sql: ${number}
    
  - measure: total_cohort
    type: sum
    sql: ${cohorts.number}