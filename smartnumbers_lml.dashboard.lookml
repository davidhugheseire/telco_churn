- dashboard: smartnumbers_lml
  title: Repeat and blacklisted callers
  layout: newspaper
  elements:
  - title: Male
    name: Male
    model: dave_customer_churn
    explore: customers
    type: looker_bar
    fields: [customers.row_num, customers.charge]
    filters:
      customers.gender: Male
    sorts: [customers.charge desc]
    limit: 500
    dynamic_fields: [{table_calculation: numbers, label: Numbers, expression: "if(\n\
          \  (length(${customers.row_num}) > 10), concat(substring(${customers.row_num},\
          \ 0, 10),\"....\"),\"no\")", value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    query_timezone: America/Los_Angeles
    series_types: {}
    hidden_fields: [customers.row_num]
    listen: {}
    row: 0
    col: 0
    width: 10
    height: 13
  - title: Female
    name: Female
    model: dave_customer_churn
    explore: customers
    type: looker_bar
    fields: [customers.row_num, customers.charge]
    filters:
      customers.gender: Female
    sorts: [customers.charge desc]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 0
    col: 12
    width: 10
    height: 13
