//
//  HomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

public let expenseNotification = Notification.Name("expenseNotification")
public let incomeNotification = Notification.Name("incomeNotification")
public let savingsNotification = Notification.Name("savingsNotification")

var defaultTarget = Target(name: "Yagaa", amount: 10000, date: Date())

//var defaultSavings = Savings(name: "My Savings", expendableAmount: 6000, inexpendableAmount: 4000)

var savings0 = Savings(name: "My Savings", expendableAmount: 6000, inexpendableAmount: 4000)
var savings1 = Savings(name: "My Savings", expendableAmount: 6000, inexpendableAmount: 4000)
var savings2 = Savings(name: "My Savings", expendableAmount: 6000, inexpendableAmount: 4000)

var savingsList: Array<Savings> = [savings0, savings1, savings2]

var savingsNameList = ["FD", "Zerodha", "Account"]

var savingsID = 0

class HomeController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var markStack: UIStackView!
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var incomeTableView: UITableView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var markValue: UILabel!
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var savingsButton: UIButton!
    
    var targetID = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToExpenseNotification(_:)), name: expenseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reactToIncomeNotification(_:)), name: incomeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reactToSavingsNotification(_:)), name: savingsNotification, object: nil)
        
        prepareSavings(id: savingsID)
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.systemBlue], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        
        targetLabel.text = String(defaultTarget.amount)
        savingsLabel.text = String(savingsList[savingsID].totalAmount)
        
        savingsButton.setTitle("\(savingsNameList[savingsID]) >", for: .normal)
        
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
    
    @IBAction func onTargetPressed(_ sender: UIButton) {
    }
    
    @IBAction func onSavingsPressed(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Select Savings", message: "", preferredStyle: .alert)
        
        for i in 0..<savingsNameList.count {
            let action = UIAlertAction(title: savingsNameList[i], style: .default) { (action) in
                savingsID = i
                let nc = NotificationCenter.default
                nc.post(name: savingsNotification, object: nil)
            }
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reactToExpenseNotification(_ sender: Notification) {
        self.expenseTableView.reloadData()
        editMark()
    }
    
    @objc func reactToIncomeNotification(_ sender: Notification) {
        self.incomeTableView.reloadData()
        editMark()
    }
    
    @objc func reactToSavingsNotification(_ sender: Notification) {
        self.editMark()
        self.savingsLabel.text = String(savingsList[savingsID].totalAmount)
        self.savingsButton.setTitle("\(savingsNameList[savingsID]) >", for: .normal)
        
        self.expenseTableView.reloadData()
        self.incomeTableView.reloadData()
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
    
    func editMark() {
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
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.expenseTableView ? expenseList[savingsID].count : incomeList[savingsID].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.expenseTableView {
            let expense = expenseList[savingsID][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeExpenseCell") as! ExpenseCell
            cell.setExpense(expense: expense)
            return cell
        }
        else {
            let income = incomeList[savingsID][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeIncomeCell") as! IncomeCell
            cell.setIncome(income: income)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView == self.expenseTableView {
                if expenseList[savingsID][indexPath.row].isExecuted {
                    savingsList[savingsID].totalAmount += expenseList[savingsID][indexPath.row].amount
                }
                expenseList[savingsID].remove(at: indexPath.row)
                // Notify to HomeController and ExpenseController
                let nc = NotificationCenter.default
                nc.post(name: expenseNotification, object: nil)
            }
            else {
                if expenseList[savingsID][indexPath.row].isExecuted {
                    savingsList[savingsID].totalAmount -= incomeList[savingsID][indexPath.row].amount
                }
                incomeList[savingsID].remove(at: indexPath.row)
                // Notify to HomeController and ExpenseController
                let nc = NotificationCenter.default
                nc.post(name: incomeNotification, object: nil)
            }
        }
    }
}

func computeMark() -> (Bool, Float) {
    let value = savingsList[savingsID].totalAmount - defaultTarget.amount
    if value < 0 {
        return (false, -value)
    }
    else {
        return (true, value)
    }
}

func prepareSavings(id: Int) {
    var i0: Float = 0.0
    var e0: Float = 0.0
    for i in 0..<incomeList[id].count {
        if incomeList[id][i].isExecuted {
            i0 += incomeList[id][i].amount
        }
    }
    for i in 0..<expenseList[id].count {
        if expenseList[id][i].isExecuted {
            e0 += expenseList[id][i].amount
        }
    }
    savingsList[savingsID].totalAmount = savingsList[savingsID].totalAmount + i0 - e0
}
