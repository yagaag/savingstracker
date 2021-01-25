//
//  IncomeCell.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 23/01/21.
//

import UIKit

class IncomeCell: UITableViewCell {
    
    @IBOutlet weak var incomeName: UILabel!
    @IBOutlet weak var incomeAmount: UILabel!
    @IBOutlet weak var executeSwitch: UISwitch!
    
    func setIncome(income: Income) {
        incomeName.text = income.name
        incomeAmount.text = String(income.amount)
        executeSwitch.setOn(income.isExecuted, animated: true)
    }
    
    @IBAction func onExecuted(_ sender: UISwitch) {
        incomes[self.indexPath!.row].isExecuted = sender.isOn
        
        if sender.isOn {
            defaultSavings.totalAmount += incomes[self.indexPath!.row].amount
        }
        else {
            defaultSavings.totalAmount -= incomes[self.indexPath!.row].amount
        }
        
        // Notify to HomeController and IncomeController
        let nc = NotificationCenter.default
        nc.post(name: incomeNotification, object: nil)
    }
}
