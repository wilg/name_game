- explore: names_step1
  hidden: true
  
- view: names_step1
  sql_table_name: names
  fields:
  - dimension: name
  - dimension: gender
  - dimension: state
  - dimension: year
    type: number
  - dimension: number
    type: number

  - measure: name_count
    type: count_distinct
    sql: ${name}
    drill_fields: [name, total_number]

  - measure: total_number
    type: sum
    sql: ${number}
  