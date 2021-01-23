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
        executeSwitch.setOn(expense.isExecuted, animated: false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onExecuted(_ sender: UISwitch) {
        
    }
    
}
