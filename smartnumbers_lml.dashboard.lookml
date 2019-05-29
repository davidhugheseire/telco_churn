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
    limit: 10
    query_timezone: America/Los_Angeles
    series_types: {}
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
