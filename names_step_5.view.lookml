- view: names_step_5
  extends: names_step_4
  sql_table_name: |
      (SELECT 
        *,
        RANK() OVER (
          PARTITION BY year, state, gender 
          ORDER BY number DESC) as name_rank
      FROM names) 
    
  fields:
  - dimension: name_rank
    type: number
    
  - measure: average_name_rank
    type: average
    sql: ${name_rank}