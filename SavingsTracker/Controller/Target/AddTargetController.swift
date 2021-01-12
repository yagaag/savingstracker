//
//  TargetController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

var target = Target(name: "test", amount: 100, date: Date())

protocol AddTargetControllerDelegate : NSObjectProtocol {
    func reactToAddTarget(actionType: String, name: String, amount: String)
}

class AddTargetController: UIViewController {
    
    weak var delegate: AddTargetControllerDelegate?
    
    // Notify to HomeController
    let nc = NotificationCenter.default
    
    @IBOutlet weak var currentTarget: UILabel!
    @IBOutlet weak var targetName: UITextField!
    @IBOutlet weak var targetAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTargetAdded(_ sender: UIButton) {
        
        targetName.endEditing(true)
        targetAmount.endEditing(true)
        if let amount = targetAmount.text {
            SavingsTracker.target = Target(name: targetName.text!, amount: Float(amount)!, date: Date())
            print(SavingsTracker.target.amount)
            nc.post(name: kNotification, object: nil)
        }
        if let delegate = delegate {
            delegate.reactToAddTarget(actionType: "Add", name: targetName.text!, amount: targetAmount.text!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        
        if let delegate = delegate {
            delegate.reactToAddTarget(actionType: "Back", name: "nil", amount: "nil")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
