# Suggest gender neutral Names
- explore: names_step2_suggest
  hidden: true
- view: names_step2_suggest
  derived_table:
    sql: |
      SELECT
        name
      FROM names
      GROUP BY name
      HAVING 
        SUM(CASE WHEN gender='M' THEN number ELSE 0 END)::float / SUM(number) BETWEEN 0.2 AND 0.8
        AND SUM(number) > 5000
  fields:
  - dimension: name

