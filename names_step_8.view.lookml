- view: names_step_8
  extends: [names_step_7, suggest]
  fields:
  - dimension: name
    links:
    - label: Search Wikipedia for {{value}}
      url: https://en.wikipedia.org/wiki/{{value}}
      icon_url: https://en.wikipedia.org/static/favicon/wikipedia.ico