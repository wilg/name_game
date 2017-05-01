#
# bucketing the data by
#   decade
#   region
#   first letter of the name
#
- view: names_step_2
  extends: names_step_1
  fields:
  # computed dimensions
  - dimension: decade
    type: number
    sql: FLOOR(${year}/10) * 10
    value_format: "0000"
    
  - dimension: region
    sql_case:
      West: |
        ${state} in ('WA','OR','CA','NV','UT','WY','ID','MT',
            'CO','AK','HI')
      Southwest: ${state} in ('AZ','NM','TX','OK')
      Midwest: |
        ${state} in ('ND','SD','MN','IA','WI','MN','OH','IN','MO','NE',
            'KS','MI','IL')
      Northeast: |
        ${state} in ('MD','DE','NJ','CT','RI','MA','NH','PA',
            'NY','VT','ME','DC')
      Southeast: |
        ${state} in ('AR','LA','MS','AL','GA','FL','SC','NC','VA','TN',
            'KY','WV')
      Unset: true
    drill_fields: [state]
    
  - dimension: westness
    hidden: true
    type: number
    sql: |
      CASE WHEN ${region} = 'West' THEN 1 
           WHEN ${region} = 'Southwest' THEN 0.7 
           WHEN ${region} = 'Midwest' THEN 0.75
           WHEN ${region} = 'Northeast' THEN 0
           WHEN ${region} = 'Southeast' THEN 0.2
           ELSE 0
       END
    
  - dimension: westness
    hidden: true
    type: number
    sql: |
      CASE WHEN ${region} = 'West' THEN 1 
           WHEN ${region} = 'Southwest' THEN 0.7 
           WHEN ${region} = 'Midwest' THEN 0.75
           WHEN ${region} = 'Northeast' THEN 0
           WHEN ${region} = 'Southeast' THEN 0.2
           ELSE 0
       END
       
  - dimension: northness
    hidden: true
    type: number
    sql: |
      CASE WHEN ${region} = 'West' THEN 0.6
           WHEN ${region} = 'Southwest' THEN 0
           WHEN ${region} = 'Midwest' THEN 0.2
           WHEN ${region} = 'Northeast' THEN 1
           WHEN ${region} = 'Southeast' THEN 0
           ELSE 0
       END
       
  - measure: average_westness
    hidden: true
    type: average
    sql: ${westness}
    
  - measure: average_northness
    hidden: true
    type: average
    sql: ${northness}

  - dimension: first_letter
    sql: SUBSTRING(${name},1,1)
    drill_fields: [name, gender]
