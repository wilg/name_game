- explore: names_step2
  hidden: true
  
- view: names_step2
  sql_table_name: names
  fields:
  - dimension: name
  - dimension: gender
  - dimension: state
  - dimension: year
    type: number
  - dimension: number
    type: number

  - dimension: name_gender
    sql: ${name} || '-' || ${gender}

  - measure: name_count
    type: count_distinct
    sql: ${name}
    drill_fields: [name, total_number]

  - measure: total_number
    type: sum
    sql: ${number}
    
  - measure: total_male
    type: sum
    sql: ${number}
    filters:
      gender: M

  - measure: percent_male
    type: number
    sql: 100.0 * ${total_male} / ${total_number}
