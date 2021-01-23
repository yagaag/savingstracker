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
    
    
    @IBOutlet weak var expenseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToNotification(_:)), name: kNotification, object: nil)
        self.expenseTableView.rowHeight = 60.0
    }
    
    @objc func reactToNotification(_ sender: Notification) {
        
        print("Reacting...")
    }
    
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeExpenseCell") as! ExpenseCell
        cell.setExpense(expense: expense)
        return cell
    }
}
