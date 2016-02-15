# Shared implementation between Redshift and BigQuery

# basic model out of the generator
- explore: names_step_0
  hidden: true
  
# add some simple measures
- explore: names_step_1
  hidden: true

# add some simple dimensions
- explore: names_step_2
  hidden: true

# add some filtered measure to analyse specific things
- explore: names_step_3
  hidden: true

# build a percent of cohort to normalize data
- explore: names_step_4
  hidden: true
  joins:
  - join: cohorts
    sql_on: |
      ${state} = ${cohorts.state}
      AND ${year} = ${cohorts.year}
      AND ${gender} = ${cohorts.gender}
    relationship: many_to_one
    
# rank names within state and year to find name density    
- explore: names_step_5
  extends: names_step_4
  hidden: true
