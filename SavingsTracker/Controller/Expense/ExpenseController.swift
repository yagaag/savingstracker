//
//  ExpenseController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class ExpenseController: UIViewController, UINavigationControllerDelegate, AddExpenseControllerDelegate {
    
    var expenses: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 100, target: Date(), isExecuted: true)]
    
    @IBOutlet weak var executedExpense: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Expense"
        self.tableView.rowHeight = 70.0
        
        (executedExpense.text, totalExpense.text) = getExpenses()
        
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
    
    func reactToAddExpense(actionType: String, name: String, amount: String, isExecuted: Bool) {
        expenses.append(Expense(name: name, amount: Float(amount)!, target: Date(), isExecuted: isExecuted))
        self.tableView.reloadData()
        (executedExpense.text, totalExpense.text) = getExpenses()
    }
    
    func getExpenses() -> (String, String) {
        var t1: Float = 0.0
        var t2: Float = 0.0
        for i in 0..<expenses.count {
            if expenses[i].isExecuted {
                t1 += expenses[i].amount
            }
            else {
                t2 += expenses[i].amount
            }
        }
        return (String(t1), String(t1+t2))
    }
    
}

extension ExpenseController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseCell
        cell.setExpense(expense: expense)
        return cell
    }
}
