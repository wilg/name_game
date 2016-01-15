- explore: name_year_rank
  hidden: true
  
- view: name_year_rank
  derived_table:
    sql: |
      SELECT
        *
        , MAX(cumlative_people) OVER (PARTITION BY name, gender ORDER BY year DESC ROWS UNBOUNDED PRECEDING) as total_people
      FROM (
        SELECT
          name
          , gender
          , year
          , number
          , RANK() OVER (PARTITION BY year ORDER BY number DESC) as year_rank
          , SUM(number) OVER (PARTITION by name, gender ORDER BY year ROWS UNBOUNDED PRECEDING) as cumlative_people
        FROM (
          SELECT
            name
            , gender
            , year
            , SUM(number) as number
          FROM names
          GROUP BY 1, 2, 3
        ) as n
      ) as p
  fields:
  - dimension: name
  - dimension: gender
  - dimension: year
    type: number
    
  - dimension: year_rank
    type: number
    
  - measure: average_year_rank
    type: average
    sql: ${year_rank}
    
  - dimension: cumlative_people
    type: number
    
  - dimension: total_people
    type: number

    