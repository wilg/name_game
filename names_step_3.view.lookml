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
    sql: ${number}
    filters:
      gender: M
      
  - measure: male_percentage
    type: number
    sql: 100.0 * ${male_population} / ${total_population} 
    
  - measure: north_east_population
    type: sum
    sql: ${number}
    filters:
      region: Northeast
      
  - measure: north_east_percentage
    sql: 100.0 * ${north_east_population} / ${total_population}
    
  - measure: before_1940_population
    type: sum
    sql: ${number}
    filters:
      year: "< 1940"
      
  - measure: before_1940_percentage
    sql: 100.0 * ${before_1940_population} / ${total_population}
