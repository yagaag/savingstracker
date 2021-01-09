//
//  TargetController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var target = Target(name: "test", amount: 100, date: Date())

class TargetController: UIViewController {
    
    // Notify to HomeController
    let nc = NotificationCenter.default
    
    @IBOutlet weak var currentTarget: UILabel!
    @IBOutlet weak var targetName: UITextField!
    @IBOutlet weak var targetAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onTargetChanged(_ sender: UIButton) {
        
        targetName.endEditing(true)
        targetAmount.endEditing(true)
        if let amount = targetAmount.text {
            SavingsTracker.target = Target(name: targetName.text!, amount: Float(amount)!, date: Date())
            print(SavingsTracker.target.amount)
            nc.post(name: kNotification, object: nil)
        }
        
        targetName.text = ""
        targetAmount.text = ""
        
    }
    
    
}
