#
# Add some very basic comutations to
#  calculate the number of different names
#  the total size of the population

- view: names_step_1      # make a new view, names_step_1
  extends: names_step_0   # use all the fields in names_step_0
                          #  and add or change the following fields
  fields:

  # number of Different Names
  - measure: name_count
    type: count_distinct
    sql: ${name}
    drill_fields: [name, total_population]

  # sum the populations
  - measure: total_population
    type: sum
    sql: ${number}
  
  # Don't show a comma when displaying years.
  - dimension: year
    value_format: "0000"
