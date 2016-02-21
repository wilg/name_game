- view: name_gender
  fields:
      
  - dimension: name_gender
    suggest_explore: names_gender_suggest
    suggest_dimension: name_gender
    sql: |
      CONCAT(${name},'-' ,${gender})
      
      
- explore: names_gender_suggest
  hidden: true
  
- view: names_gender_suggest
  derived_table:
    sql: |
      SELECT 
        CONCAT(name, '-' , gender) as name_gender
        , SUM(number)
      FROM
        {% if _dialect._name == 'bigquery' %}
          [fh-bigquery:popular_names.usa_1910_2013]
        {% else %}
          names
        {% endif %}
      GROUP BY 1
      ORDER by 2 DESC
      
  fields:
  - dimension: name_gender
