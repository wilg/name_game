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
      
  - dimension: first_letter
    sql: SUBSTRING(${name},1,1)
