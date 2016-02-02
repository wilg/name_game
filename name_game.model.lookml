- connection: imdb
- include: "*.view.lookml"

- explore: names_step_0
  hidden: true
  
- explore: names_step_1
  hidden: true

- explore: names_step_2
  hidden: true

- explore: names_step_3
  hidden: true

- explore: names_step_4
  hidden: true
  joins:
  - join: cohorts
    sql_on: |
      ${state} = ${cohorts.state}
      AND ${year} = ${cohorts.year}
      AND ${gender} = ${cohorts.gender}
    relationship: many_to_one
    
- explore: names_step_5
  extends: names_step_4
  hidden: true
