connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"
include: "*.dashboard"

datagroup: dave_customer_churn_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: bqml_datagroup {
  max_cache_age: "24 hour"
  sql_trigger: SELECT CURRENT_DATE() ;;
}

persist_with: dave_customer_churn_default_datagroup

# explore: customers {
#   always_filter: {
#     filters: {
#       field: customer_id
#       value: "-NULL"
#     }
# }



explore: churn_model_training_info {}
explore: churn_model_evaluation  {}
explore: churn_roc_curve {}
explore: churn_prediction {}
explore: daves_pdt {}



explore: customers {

}
