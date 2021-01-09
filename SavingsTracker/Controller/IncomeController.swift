//
//  IncomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var income = Income(name: "test", amount: 100, isExpendable: false, target: Date(), isExecuted: false)

class IncomeController: UIViewController {
    
    // Notify to HomeController
    let nc = NotificationCenter.default
    
    @IBOutlet weak var incomeName: UITextField!
    @IBOutlet weak var incomeAmount: UITextField!
    @IBOutlet weak var executedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onIncomeAdded(_ sender: UIButton) {
        
        incomeName.endEditing(true)
        incomeAmount.endEditing(true)
        if let amount = incomeAmount.text {
            income = Income(name: incomeName.text!, amount: Float(amount)!, isExpendable: false, target: Date(), isExecuted: executedSwitch.isOn)
            print(income.amount)
            print(income.isExecuted)
            if income.isExecuted {
                savings.totalAmount = savings.totalAmount + income.amount
                nc.post(name: kNotification, object: nil)
            }
        }
        
        incomeName.text = ""
        incomeAmount.text = ""
        
    }
    
}
