//
//  ExpenseCell.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 23/01/21.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var executeSwitch: UISwitch!
    
    func setExpense(expense: Expense) {
        nameLabel.text = expense.name
        amountLabel.text = String(expense.amount)
        executeSwitch.setOn(expense.isExecuted, animated: true)
    }
    
    @IBAction func onExecuted(_ sender: UISwitch) {
        expenseList[savingsID][self.indexPath!.row].isExecuted = sender.isOn
        
        if sender.isOn {
            savingsList[savingsID].totalAmount -= expenses[self.indexPath!.row].amount
        }
        else {
            savingsList[savingsID].totalAmount += expenses[self.indexPath!.row].amount
        }
        
        // Notify to HomeController and ExpenseController
        let nc = NotificationCenter.default
        nc.post(name: expenseNotification, object: nil)
    }
}

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
