# Finding 
#  gender neutral vs. gender specific names
#  old names vs new names
#  northeast names vs not northeast names

- view: names_step_3
  extends: names_step_2
  fields:
  
  # filtered measures
  
  - measure: male_population
    type: sum
    sql: ${population}
    filters:
      gender: M
      
  - measure: male_percentage
    type: number
    sql: ${male_population} / ${total_population} 
    value_format_name: percent_2
    
  - measure: north_east_population
    type: sum
    sql: ${population}
    filters:
      region: Northeast
      
  - measure: north_east_percentage
    type: number
    sql: ${north_east_population} / ${total_population}
    value_format_name: percent_2
    
  - measure: before_1940_population
    type: sum
    sql: ${population}
    filters:
      year: "< 1940"
      
  - measure: before_1940_percentage
    type: number
    sql: ${before_1940_population} / ${total_population}
    value_format_name: percent_2
