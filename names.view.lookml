- view: names
  derived_table:
    sql_trigger_value: SELECT COUNT(*) from names
    indexes: [name]
    sql: |
        SELECT
          *
          , ROW_NUMBER() OVER(ORDER BY year, name, gender) as id
          , RANK() OVER (PARTITION BY year, gender, state ORDER BY number DESC) as name_rank
        FROM 
          names
    
  fields:
  - dimension: id
    hidden: true
  - dimension: name
  - dimension: number
    type: number
  - dimension: state
  - dimension: year
    type: number
  - dimension: gender
  
  - dimension: name_gender
    sql: ${name} || '-' || ${gender}
  
  - dimension: name_rank
    type: number

  - measure: total_number
    type: sum
    sql: ${number}
    
  - measure: total_cohort
    type: sum
    sql: ${cohorts.number}
    
  - measure: percent_of_cohort
    type: number
    sql: 100.0 * ${total_number} / ${cohorts.cohort_size}
    value_format: "##.######"