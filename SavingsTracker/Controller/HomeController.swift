//
//  HomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var savings = Savings(name: "My Savings", expendableAmount: 200, inexpendableAmount: 400)

public let kNotification = Notification.Name("kNotification")

class HomeController: UIViewController {
    
    @IBOutlet weak var savingsAmount: UILabel!
    @IBOutlet weak var targetAmount: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        savingsAmount.text = String(savings.totalAmount)
        targetAmount.text = String(SavingsTracker.target.amount)
        NotificationCenter.default.addObserver(self, selector: #selector(reactToNotification(_:)), name: kNotification, object: nil)
    }
    
    @IBAction func onExecuteIncome(_ sender: UIButton) {
        
        print(sender.backgroundColor)
        
        if sender.backgroundColor == .white {
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .systemBlue
        }
        else {
            sender.setTitleColor(.systemBlue, for: .normal)
            sender.backgroundColor = .white
        }
        
    }
    
    @IBAction func onExecuteExpense(_ sender: UIButton) {
        
        print("Expense")
        print(sender.backgroundColor)

        if sender.backgroundColor == .white {
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .systemBlue
        }
        else {
            sender.setTitleColor(.systemBlue, for: .normal)
            sender.backgroundColor = .white
        }
        
    }
    
    @objc func reactToNotification(_ sender: Notification) {
        
        print("Reacting...")
        
        savingsAmount.text = String(savings.totalAmount)
        targetAmount.text = String(SavingsTracker.target.amount)
    }
    
}

//if sender.backgroundColor == .clear {
//    sender.setTitleColor(.white, for: .normal)
//    sender.backgroundColor = .systemBlue
//}
//else {
//    sender.setTitleColor(.systemBlue, for: .normal)
//    sender.backgroundColor = .clear
//}
