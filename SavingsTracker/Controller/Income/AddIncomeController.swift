//
//  IncomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var income = Income(name: "test", amount: 100, isExpendable: false, target: Date(), isExecuted: false)

protocol AddIncomeControllerDelegate : NSObjectProtocol {
    func reactToAddIncome(actionType: String, name: String, amount: String, isExecuted: Bool)
}

class AddIncomeController: UIViewController {
    
    weak var delegate: AddIncomeControllerDelegate?
    
    // Notify to HomeController
    let nc = NotificationCenter.default
    
    @IBOutlet weak var incomeName: UITextField!
    @IBOutlet weak var incomeAmount: UITextField!
    @IBOutlet weak var executedSwitch: UISwitch!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 5
    }
    
    @IBAction func onIncomeAdded(_ sender: UIButton) {
        
        incomeName.endEditing(true)
        incomeAmount.endEditing(true)
        if let amount = incomeAmount.text {
            income = Income(name: incomeName.text!, amount: Float(amount)!, isExpendable: false, target: Date(), isExecuted: executedSwitch.isOn)
            print(income.amount)
            print(income.isExecuted)
            if income.isExecuted {
                defaultSavings.totalAmount = defaultSavings.totalAmount + income.amount
                //nc.post(name: kNotification, object: nil)
            }
            
            if let delegate = delegate {
                delegate.reactToAddIncome(actionType: "Add", name: incomeName.text!, amount: incomeAmount.text!, isExecuted: executedSwitch.isOn)
            }
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.reactToAddIncome(actionType: "Back", name: "nil", amount: "0", isExecuted: false)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
