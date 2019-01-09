# TRAINING DATA SET
# NDT
# Model Features
# Known Out Come - churn
# Partitioned
#
  view: churn_training_input {
    derived_table: {
      explore_source: customers {
        column: customer_id {}
        column: tech_support {}
        column: churn{}
      filters: {
        field: customers.row_num
        value: "<= 2500"
      }
    }
  }
}

# TESTING DATA SET
# Training Data different partition range of data
# NDT
# Known Out Come - churn
# Partitioned
#
  view: churn_testing_input {
    derived_table: {
      explore_source: customers {
        column: customer_id {}
        column: tech_support {}
        column: churn{}
        filters: {
          field: customers.row_num
          value: ">= 2500"
        }
    }
  }
}

######################## MODEL #############################
# Algorythm logistic regression, binary outcome, linear reg for range
# Column we are predicting
# Measure of improvment if it doesnt improve more than 0.005 quit
# Iterate through the algorythm 40 times
#
#
#
#
#
  view: churn_model {
    derived_table: {
      datagroup_trigger: bqml_datagroup
      sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='logistic_reg'
        , labels=['churn']
        , min_rel_progress = 0.005
        , max_iterations = 40
        , data_split_method='auto_split'
        ) AS
      SELECT
         * EXCEPT(customer_id)
      FROM ${churn_training_input.SQL_TABLE_NAME};;
    }
  }


######################## TRAINING INFORMATION #############################
# Less about how the model performed and more about
# How long it took to train
# How many iteration it took
# How much did it improve over thoes iterations
#
#
#
#
#
view: churn_model_training_info {
  derived_table: {
    sql: SELECT  * FROM ml.TRAINING_INFO(MODEL ${churn_model.SQL_TABLE_NAME});;
  }


  dimension: training_run {
    type: number
  }
  dimension: iteration {
    type: number
  }
  dimension: loss_raw {
    type: number hidden:yes
    sql: ${TABLE}.loss;;
  }
  dimension: eval_loss {
    type: number
  }
  dimension: duration_ms {
    label:"Duration (ms)" type: number
  }
  dimension: learning_rate {
    type: number
  }
  measure: total_iterations {
    type: count
  }
  measure: loss {
    value_format_name: decimal_2
    type: sum
    sql:  ${loss_raw} ;;
  }
  measure: total_training_time {
    type: sum
    label:"Total Training Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  measure: average_iteration_time {
    type: average
    label:"Average Iteration Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
}


######################## MODEL EVALUATION INFORMATION #############################
# Functions for evaluating the model
# Takes our model as input,  the model we created above
# test it against out testing dataset
# ml.EVALUATE function
#
#
#
#

  view: churn_model_evaluation {
    derived_table: {
      sql: SELECT * FROM ml.EVALUATE(
          MODEL ${churn_model.SQL_TABLE_NAME},
          (SELECT * FROM ${churn_testing_input.SQL_TABLE_NAME}));;
    }

    dimension: recall {
      type: number
      value_format_name:percent_2
    }

    dimension: accuracy {
      type: number
      value_format_name:percent_2
    }

    dimension: f1_score {
      type: number
      value_format_name:percent_2
    }

    dimension: log_loss {
      type: number
    }

    dimension: roc_auc {
      type: number
    }
  }

######################## MODEL EVALUATION ##############################

  view: churn_roc_curve {
    derived_table: {
      sql: SELECT * FROM ml.ROC_CURVE(
        MODEL ${churn_model.SQL_TABLE_NAME},
        (SELECT * FROM ${churn_testing_input.SQL_TABLE_NAME}));;
    }

    dimension: threshold {
      type: number
      value_format: "0.00\%"
    }

    dimension: recall {
      type: number
      value_format_name: percent_2
    }

    dimension: false_positive_rate {
      type: number
    }

    dimension: true_positives {
      type: number
    }

    dimension: false_positives {
      type: number
    }

    dimension: true_negatives {
      type: number
    }

    dimension: false_negatives {
      type: number
    }

    dimension: precision {
      type:  number
      value_format_name: percent_2
      sql:  ${true_positives} / NULLIF((${true_positives} + ${false_positives}),0);;
    }

    measure: total_false_positives {
      type: sum
      sql: ${false_positives} ;;
    }
    measure: total_true_positives {
      type: sum
      sql: ${true_positives} ;;
    }
    dimension: threshold_accuracy {
      type: number
      value_format_name: percent_2
      sql:  1.0*(${true_positives} + ${true_negatives}) / NULLIF((${true_positives} + ${true_negatives} + ${false_positives} + ${false_negatives}),0);;
    }
    dimension: threshold_f1 {
      type: number
      value_format_name: percent_3
      sql: 2.0*${recall}*${precision} / NULLIF((${recall}+${precision}),0);;
    }
  }


########################################## PREDICT FUTURE ############################
#
#
#
#
#
  view: churn_future_input {
    derived_table: {
      explore_source: customers {
        column: customer_id {}
        column: tech_support {}
        filters: {
          field: customers.row_num
          value: "<= 3000"
        }
      }
    }
  }


  view: churn_prediction {
    derived_table: {
      sql: SELECT * FROM ml.PREDICT(
          MODEL ${churn_model.SQL_TABLE_NAME},
          (SELECT * FROM ${churn_future_input.SQL_TABLE_NAME}));;
    }

    dimension: id {
      hidden: yes
      primary_key: yes
      type: number
    }

    dimension: predicted_churn {
      type: number
    }

    measure: max_predicted_score {
      type: max
      value_format_name: percent_2
      sql: ${predicted_churn} ;;
    }

    measure: average_predicted_score {
      type: average
      value_format_name: percent_2
      sql: ${predicted_churn} ;;
    }
  }
