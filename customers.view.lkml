view: customers {
  sql_table_name: telco_churn.customers ;;

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customerID ;;
  }

  dimension: row_num {
    type: number
    sql: ${TABLE}.Row_Num ;;
  }

  dimension: churn {
    type: number
    sql: ${TABLE}.Churn ;;
  }

  dimension: contract {
    type: string
    sql: ${TABLE}.Contract ;;
  }

  dimension: dependents {
    type: yesno
    sql: ${TABLE}.Dependents ;;
  }

  dimension: device_protection {
    type: string
    sql: ${TABLE}.DeviceProtection ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: internet_service {
    type: string
    sql: ${TABLE}.InternetService ;;
  }

  dimension: monthly_charges {
    type: number
    sql: ${TABLE}.MonthlyCharges ;;
  }

  dimension: multiple_lines {
    type: string
    sql: ${TABLE}.MultipleLines ;;
  }

  dimension: online_backup {
    type: string
    sql: ${TABLE}.OnlineBackup ;;
  }

  dimension: online_security {
    type: string
    sql: ${TABLE}.OnlineSecurity ;;
  }

  dimension: paperless_billing {
    type: yesno
    sql: ${TABLE}.PaperlessBilling ;;
  }

  dimension: partner {
    type: yesno
    sql: ${TABLE}.Partner ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.PaymentMethod ;;
  }

  dimension: phone_service {
    type: yesno
    sql: ${TABLE}.PhoneService ;;
  }

  dimension: senior_citizen {
    type: number
    sql: ${TABLE}.SeniorCitizen ;;
  }

  dimension: streaming_movies {
    type: string
    sql: ${TABLE}.StreamingMovies ;;
  }

  dimension: streaming_tv {
    type: string
    sql: ${TABLE}.StreamingTV ;;
  }

  dimension: tech_support {
    type: string
    sql: ${TABLE}.TechSupport ;;
  }

  dimension: tenure {
    type: number
    sql: ${TABLE}.tenure ;;
  }

  dimension: total_charges {
    type: string
    sql: ${TABLE}.TotalCharges ;;
  }

  measure: count {
    type: count
  }
}
