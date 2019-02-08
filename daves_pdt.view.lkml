view: daves_pdt {
    derived_table: {
      explore_source: customers {
        column: customer_id {}
        column: monthly_charges {}
        column: online_security {}
        column: gender {}
        column: dependents {}
        column: partner {}
      }
    }
    dimension: customer_id {}
    dimension: monthly_charges {
      type: number
    }
    dimension: online_security {}
    dimension: gender {}
    dimension: dependents {
      label: "Customers Dependents (Yes / No)"
      type: yesno
    }
    dimension: partner {
      label: "Customers Partner (Yes / No)"
      type: yesno
    }
  }
