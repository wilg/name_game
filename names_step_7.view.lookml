- view: names_step_7
  extends: names_step_6
  fields:
  - measure: name_list
    type: list
    list_field: name

  - dimension: year_string
    sql: STRING(${year})
    hidden: true
  
  - measure: year_list
    type: list
    list_field: year_string

  - measure: state_list
    type: list
    list_field: state
    
  - measure: min_year
    type: min
    sql: ${year}
    
  - measure: max_year
    type: max
    sql: ${year}    
    
  - dimension: is_15_percent_year
    type: yesno
    sql: ${names_facts.year_15_percent} = ${year}
    
  - dimension: is_median_year
    type: yesno
    sql: ${names_facts.year_median} = ${year}    
    
  - dimension: is_85_percent_year
    type: yesno
    sql: ${names_facts.year_85_percent} = ${year}    