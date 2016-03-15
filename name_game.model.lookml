- connection: lookerdata_publicdata

- include: "names*.view.lookml" 

- persist_for: 10000 hours

# basic model out of the generator
- explore: names_step_0
  hidden: true
  
# add some simple measures
- explore: names_step_1
  hidden: true

# add some simple dimensions
- explore: names_step_2
  label: Name Game Basic
  #hidden: true

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

# Add a fact table
- explore: names_step_6
  extends: names_step_5
  joins:
  - join: names_facts
    sql_on: |
      ${name} = ${names_facts.name}
      AND ${gender} = ${names_facts.gender}
    relationship: many_to_one

# add some lists
- explore: names_step_7
  extends: names_step_6

# add some external links
- explore: names_step_8
  extends: names_step_7
 
# add some external links
- explore: names_step_9
  extends: names_step_8
  view: name_game
  from: names_step_9
  joins:
  - join: target
    type: cross
    relationship: one_to_one

# place to start exploring from 
- explore: name_game
  extends: names_step_8
  from: names_step_8
  hidden: false