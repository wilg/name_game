- view: names_step_8
  extends: [names_step_7, suggest]
  fields:
  - dimension: name
    links:
    - label: Search Wikipedia for {{value}}
      url: https://en.wikipedia.org/wiki/{{value}}
      icon_url: https://en.wikipedia.org/static/favicon/wikipedia.ico
  
  - dimension: is_laggard
    type: yesno
    sql: ${year} > ${names_facts.year_85_percent}
  
  - measure: is_laggard_year
    type: min
    sql: (CASE WHEN ${is_laggard} = 0 then NULL ELSE ${is_laggard} END)
    
  - dimension: is_early_adopter
    type: yesno
    sql: ${year} < ${names_facts.year_15_percent}
  
  - measure: is_early_adopter_year
    type: min
    sql: (CASE WHEN ${is_early_adopter} = 0 then NULL ELSE ${is_early_adopter} END)
  
  - measure: is_peak_year
    type: min
    sql: (CASE WHEN ${is_early_adopter} = 1 OR ${is_laggard} = 1 then NULL ELSE 1 END)
    
  - dimension: adoption_category
    sql_case: 
      Early Adopters: ${year} < ${names_facts.year_15_percent}
      Laggards: ${year} > ${names_facts.year_85_percent}
      Peak: true