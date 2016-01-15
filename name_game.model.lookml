- connection: imdb
- include: "*.view.lookml"

- explore: names
  hidden: true
  joins:
  - join: cohorts
    sql_on: |
      ${names.year} = ${cohorts.year} AND ${names.state} = ${cohorts.state} 
        AND ${names.gender} = ${cohorts.gender}
    relationship: many_to_one