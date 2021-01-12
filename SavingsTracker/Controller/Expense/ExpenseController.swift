//
//  ExpenseController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class ExpenseController: UIViewController, UINavigationControllerDelegate, AddExpenseControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Expense"
    }
    
    
    @IBAction func onAddExpense(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addExpense", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addExpense" {
            let destinationVC = segue.destination as! AddExpenseController
            destinationVC.delegate = self
        }
    }
    
    func reactToAddExpense(actionType: String, name: String, amount: String) {
        print("\(actionType), \(name), \(amount)")
    }
    
}
