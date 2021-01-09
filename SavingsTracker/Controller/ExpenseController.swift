//
//  ExpenseController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var expense = Expense(name: "test", amount: 100, target: Date(), isExecuted: false)

class ExpenseController: UIViewController {
    
    let nc = NotificationCenter.default
    
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var executedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onExpenseAdded(_ sender: UIButton) {
        
        expenseName.endEditing(true)
        expenseAmount.endEditing(true)
        if let amount = expenseAmount.text {
            expense = Expense(name: expenseName.text!, amount: Float(amount)!, target: Date(), isExecuted: executedSwitch.isOn)
            print(expense.amount)
            print(expense.isExecuted)
            if expense.isExecuted {
                savings.totalAmount = savings.totalAmount - expense.amount
                nc.post(name: kNotification, object: nil)
            }
        }
        
        expenseName.text = ""
        expenseAmount.text = ""
        
    }
    
}
