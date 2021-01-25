//
//  ExpenseController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class ExpenseController: UIViewController, UINavigationControllerDelegate, AddExpenseControllerDelegate {
    
    @IBOutlet weak var executedExpense: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToExpenseNotification(_:)), name: expenseNotification, object: nil)
        
        self.tableView.rowHeight = 70.0
        
        let (a, b) = getExpenses()
        (executedExpense.text, totalExpense.text) = (String(a), String(b))
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
        let (a, b) = getExpenses()
        (executedExpense.text, totalExpense.text) = (String(a), String(b))
        // Notify to HomeController
        let nc = NotificationCenter.default
        nc.post(name: expenseNotification, object: nil)
    }
    
    @objc func reactToExpenseNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getExpenses()
        (executedExpense.text, totalExpense.text) = (String(a), String(b))
    }
}

func getExpenses() -> (Float, Float) {
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
    return (t1, t1+t2)
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if expenses[indexPath.row].isExecuted {
                defaultSavings.totalAmount += expenses[indexPath.row].amount
            }
            expenses.remove(at: indexPath.row)
            // Notify to HomeController and ExpenseController
            let nc = NotificationCenter.default
            nc.post(name: expenseNotification, object: nil)
        }
    }
}
