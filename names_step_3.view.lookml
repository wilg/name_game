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
      
  - measure: female_population
    type: sum
    sql: ${population}
    filters:
      gender: F
      
  - measure: male_percentage
    type: number
    sql: 1.0 * ${male_population} / ${total_population} 
    value_format_name: percent_0
    
  - measure: female_percentage
    type: number
    sql: 1.0 * ${female_population} / ${total_population} 
    value_format_name: percent_0
    
  - measure: unisexness
    hidden: true
    type: number
    sql: abs(${female_percentage} - 0.5)
    
  - measure: north_east_population
    hidden: true
    type: sum
    sql: ${population}
    filters:
      region: Northeast
      
  - measure: north_east_percentage
    hidden: true
    type: number
    sql:  1.0 *${north_east_population} / ${total_population}
    value_format_name: percent_2
    
  - measure: before_1940_population
    hidden: true
    type: sum
    sql: ${population}
    filters:
      year: "< 1940"
      
  - measure: before_1940_percentage
    hidden: true
    type: number
    sql:  1.0 * ${before_1940_population} / ${total_population}
    value_format_name: percent_2
