- explore: names_movies
  hidden: true

- view: names_movies
  sql_table_name: |
    [disco-parsec-659:imdb.actor_firstname_title_year]
    
  fields:
  - dimension: name
   
  - dimension: full_name
    links:
    - label: IMDb
      url: http://www.google.com/search?q=site:imdb.com+{{value}}&btnI
      icon_url: http://ia.media-imdb.com/images/G/01/imdb/images/favicon-2165806970._CB379387995_.ico
  
  - dimension: title
    links:
    - label: IMDb
      url: http://www.google.com/search?q=site:imdb.com+{{value}}-{{year._value}}&btnI
      icon_url: http://ia.media-imdb.com/images/G/01/imdb/images/favicon-2165806970._CB379387995_.ico
      
  - dimension: year
    type: number
    value_format: "0000"
  
  - measure: actor_count
    type: count_distinct
    sql: ${full_name}
    drill_fields: [full_name, roles]
  
  - measure: role_count
    type: count_distinct
    sql: CONCAT(${title},STRING(${year}),${full_name})
    drill_fields: [title, year, full_name]