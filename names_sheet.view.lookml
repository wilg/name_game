- explore: names_sheet
  persist_for: 0 seconds
  joins: 
  - join: names_facts
    sql_on: ${names_sheet.name} = ${names_facts.name}
    sql_where: ${names_facts.is_dominant_gender}
    relationship: one_to_one

- view: names_sheet
  derived_table:
    sql: |
      SELECT row_number() over() as id, *
      FROM namesheet.names
  
  fields:
  - dimension: id
    type: number
    
  - dimension: name           
    order_by_field: id    # keep the rows in the original order
  

