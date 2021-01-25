//
//  HomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

public let expenseNotification = Notification.Name("expenseNotification")
public let incomeNotification = Notification.Name("incomeNotification")

var defaultTarget = Target(name: "Yagaa", amount: 10000, date: Date())

var defaultSavings = Savings(name: "My Savings", expendableAmount: 6000, inexpendableAmount: 4000)

var expenses: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 2000, target: Date(), isExecuted: false)]

var incomes: Array<Income> = [Income(name: "Barath", amount: 3000, isExpendable: true, target: Date(), isExecuted: false), Income(name: "Sneha", amount: 8000, isExpendable: true, target: Date(), isExecuted: false)]

class HomeController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var markStack: UIStackView!
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var incomeTableView: UITableView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var markValue: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToExpenseNotification(_:)), name: expenseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reactToIncomeNotification(_:)), name: incomeNotification, object: nil)
        
        targetLabel.text = String(defaultTarget.amount)
        savingsLabel.text = String(defaultSavings.totalAmount)
        let (status, value) = computeMark()
        if status {
            markLabel.text = "On target by"
            markLabel.textColor = .systemGreen
            markValue.text = String(value)
            markValue.textColor = .systemGreen
        }
        else {
            markLabel.text = "Off target by"
            markLabel.textColor = .systemRed
            markValue.text = String(value)
            markValue.textColor = .systemRed
        }
        
        self.expenseTableView.rowHeight = 60.0
        self.incomeTableView.rowHeight = 60.0
        incomeTableView.isHidden = true
    }
    
    @objc func reactToExpenseNotification(_ sender: Notification) {
        self.expenseTableView.reloadData()
        let (status, value) = computeMark()
        if status {
            markLabel.text = "On target by"
            markLabel.textColor = .systemGreen
            markValue.text = String(value)
            markValue.textColor = .systemGreen
        }
        else {
            markLabel.text = "Off target by"
            markLabel.textColor = .systemRed
            markValue.text = String(value)
            markValue.textColor = .systemRed
        }
    }
    
    @objc func reactToIncomeNotification(_ sender: Notification) {
        self.incomeTableView.reloadData()
        let (status, value) = computeMark()
        if status {
            markLabel.text = "On target by"
            markLabel.textColor = .systemGreen
            markValue.text = String(value)
            markValue.textColor = .systemGreen
            //markStack.customize(backgroundColor: .white, radiusSize: 12.0)
        }
        else {
            markLabel.text = "Off target by"
            markLabel.textColor = .systemRed
            markValue.text = String(value)
            markValue.textColor = .systemRed
            //markStack.customize(backgroundColor: .white, radiusSize: 12.0)
        }
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

//extension UIStackView {
//    func customize(backgroundColor: UIColor, radiusSize: CGFloat) {
//        let subView = UIView(frame: bounds)
//        subView.backgroundColor = backgroundColor
//        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        insertSubview(subView, at: 0)
//        subView.layer.cornerRadius = radiusSize
//        subView.layer.masksToBounds = true
//        subView.clipsToBounds = true
//    }
//}

func computeMark() -> (Bool, Float) {
    let (executedExpenseVal, _) = getExpenses()
    let (executedIncomeVal, _) = getIncomes()
    let value = defaultSavings.totalAmount + executedIncomeVal - defaultTarget.amount - executedExpenseVal
    if value < 0 {
        return (false, -value)
    }
    else {
        return (true, value)
    }
}
