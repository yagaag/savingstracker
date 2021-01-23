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
    
    var expenses: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 100, target: Date(), isExecuted: true)]
    
    var incomes: Array<Income> = [Income(name: "Barath", amount: 3000, isExpendable: true, target: Date(), isExecuted: false), Income(name: "Sneha", amount: 10000, isExpendable: true, target: Date(), isExecuted: false)]
    
    
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var incomeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToNotification(_:)), name: kNotification, object: nil)
        
        self.expenseTableView.rowHeight = 60.0
        self.incomeTableView.rowHeight = 60.0
        incomeTableView.isHidden = true
    }
    
    @objc func reactToNotification(_ sender: Notification) {
        
        print("Reacting...")
    }
    
    @IBAction func onTableChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            incomeTableView.isHidden = true
            expenseTableView.isHidden = false
        }
        else {
            expenseTableView.isHidden = true
            incomeTableView.isHidden = false
        }
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.expenseTableView ? expenses.count : incomes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(tableView == self.expenseTableView)
        if tableView == self.expenseTableView {
            let expense = expenses[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeExpenseCell") as! ExpenseCell
            cell.setExpense(expense: expense)
            return cell
        }
        else {
            let income = incomes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeIncomeCell") as! IncomeCell
            cell.setIncome(income: income)
            return cell
        }
    }
}
