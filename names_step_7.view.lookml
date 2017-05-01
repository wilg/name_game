- view: names_step_7
  extends: names_step_6
  fields:
  - measure: name_list
    type: list
    list_field: name
    hidden: true

  - dimension: year_string
    sql: STRING(${year})
    hidden: true
    hidden: true
  
  - measure: year_list
    type: list
    list_field: year_string
    hidden: true

  - measure: state_list
    type: list
    list_field: state
    hidden: true
  
  - measure: count_states
    type: count_distinct
    sql: ${state}
    hidden: true
    
  - measure: min_year
    type: min
    sql: ${year}
    hidden: true
    
  - measure: max_year
    type: max
    sql: ${year}    
    hidden: true
    
  - dimension: is_15_percent_year
    type: yesno
    sql: ${names_facts.year_15_percent} = ${year}
    hidden: true
    
  - dimension: is_median_year
    type: yesno
    sql: ${names_facts.year_median} = ${year}   
    hidden: true
    
  - dimension: is_85_percent_year
    type: yesno
    sql: ${names_facts.year_85_percent} = ${year} 
    hidden: true