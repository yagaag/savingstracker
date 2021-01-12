//
//  IncomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class IncomeController: UIViewController, UINavigationControllerDelegate, AddIncomeControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Income"
        
    }
    
    
    @IBAction func onAddIncome(_ sender: Any) {
        self.performSegue(withIdentifier: "addIncome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addIncome" {
            let destinationVC = segue.destination as! AddIncomeController
            destinationVC.delegate = self
        }
    }
    
    func reactToAddIncome(actionType: String, name: String, amount: String) {
        print("\(actionType), \(name), \(amount)")
    }
}
