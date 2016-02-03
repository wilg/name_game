# Rank names within states and years to understand name
#  density.
#
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
    
  - dimension: name_rank_tiered
    type: tier
    tiers: [10,30,100,300,1000]
    style: integer
    sql: ${name_rank}
    
  - measure: average_name_rank
    type: average
    sql: ${name_rank}