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
        NotificationCenter.default.addObserver(self, selector: #selector(reactToSavingsNotification(_:)), name: savingsNotification, object: nil)
        
        self.navigationItem.title = savingsNameList[savingsID]
        
        self.tableView.rowHeight = 70.0
        
        let (a, b) = getExpenses(id: savingsID)
        (executedExpense.text, totalExpense.text) = (String(a), String(b))
    }

    @IBAction func onAddExpense(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addExpense", sender: self)
    }
    
    @IBAction func onSavingsPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Select Savings", message: "", preferredStyle: .alert)
        
        for i in 0..<savingsNameList.count {
            let action = UIAlertAction(title: savingsNameList[i], style: .default) { (action) in
                savingsID = i
                let nc = NotificationCenter.default
                nc.post(name: savingsNotification, object: nil)
//                self.tableView.reloadData()
//                let (a, b) = getExpenses(id: savingsID)
//                (self.executedExpense.text, self.totalExpense.text) = (String(a), String(b))
//                self.navigationItem.title = savingsNameList[savingsID]
            }
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addExpense" {
            let destinationVC = segue.destination as! AddExpenseController
            destinationVC.delegate = self
        }
    }
    
    func reactToAddExpense(actionType: String, name: String, amount: String, isExecuted: Bool) {
        if actionType == "Add" {
            expenseList[savingsID].append(Expense(name: name, amount: Float(amount)!, target: Date(), isExecuted: isExecuted))
            // Notify to HomeController and self
            let nc = NotificationCenter.default
            nc.post(name: expenseNotification, object: nil)
        }
    }
    
    @objc func reactToExpenseNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getExpenses(id: savingsID)
        (executedExpense.text, totalExpense.text) = (String(a), String(b))
    }
    
    @objc func reactToSavingsNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getExpenses(id: savingsID)
        (self.executedExpense.text, self.totalExpense.text) = (String(a), String(b))
        self.navigationItem.title = savingsNameList[savingsID]
    }
}

func getExpenses(id: Int) -> (Float, Float) {
    var t1: Float = 0.0
    var t2: Float = 0.0
    for i in 0..<expenseList[id].count {
        if expenseList[id][i].isExecuted {
            t1 += expenseList[id][i].amount
        }
        else {
            t2 += expenseList[id][i].amount
        }
    }
    return (t1, t1+t2)
}

extension ExpenseController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList[savingsID].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenseList[savingsID][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseCell
        cell.setExpense(expense: expense)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if expenseList[savingsID][indexPath.row].isExecuted {
                savingsList[savingsID].totalAmount += expenseList[savingsID][indexPath.row].amount
            }
            expenseList[savingsID].remove(at: indexPath.row)
            // Notify to HomeController
            let nc = NotificationCenter.default
            nc.post(name: expenseNotification, object: nil)
        }
    }
}
