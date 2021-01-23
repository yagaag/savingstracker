//
//  ExpenseController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var expense = Expense(name: "test", amount: 100, target: Date(), isExecuted: false)

protocol AddExpenseControllerDelegate : NSObjectProtocol {
    func reactToAddExpense(actionType: String, name: String, amount: String, isExecuted: Bool)
}

class AddExpenseController: UIViewController {
    
    weak var delegate: AddExpenseControllerDelegate?
    
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
        
        if let delegate = delegate {
            delegate.reactToAddExpense(actionType: "Add", name: expenseName.text!, amount: expenseAmount.text!, isExecuted: executedSwitch.isOn)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.reactToAddExpense(actionType: "Back", name: "nil", amount: "nil", isExecuted: false)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
