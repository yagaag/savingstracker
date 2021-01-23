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
        executeSwitch.setOn(income.isExecuted, animated: false)
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
