//
//  IncomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class IncomeController: UIViewController, UINavigationControllerDelegate, AddIncomeControllerDelegate {
    
    @IBOutlet weak var executedIncome: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reactToIncomeNotification(_:)), name: incomeNotification, object: nil)
        
        self.tableView.rowHeight = 70.0
        
        let (a, b) = getIncomes()
        (executedIncome.text, totalIncome.text) = (String(a), String(b))
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
    
    func reactToAddIncome(actionType: String, name: String, amount: String, isExecuted: Bool) {
        incomes.append(Income(name: name, amount: Float(amount)!, isExpendable: true, target: Date(), isExecuted: isExecuted))
        self.tableView.reloadData()
        let (a, b) = getIncomes()
        (executedIncome.text, totalIncome.text) = (String(a), String(b))
        // Notify to HomeController
        let nc = NotificationCenter.default
        nc.post(name: incomeNotification, object: nil)
    }
    
    @objc func reactToIncomeNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getIncomes()
        (executedIncome.text, totalIncome.text) = (String(a), String(b))
    }
}

func getIncomes() -> (Float , Float) {
    var t1: Float = 0.0
    var t2: Float = 0.0
    for i in 0..<incomes.count {
        if incomes[i].isExecuted {
            t1 += incomes[i].amount
        }
        else {
            t2 += incomes[i].amount
        }
    }
    return (t1, t1+t2)
}

extension IncomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let income = incomes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell") as! IncomeCell
        cell.setIncome(income: income)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if incomes[indexPath.row].isExecuted {
                defaultSavings.totalAmount -= incomes[indexPath.row].amount
            }
            incomes.remove(at: indexPath.row)
            // Notify to HomeController and ExpenseController
            let nc = NotificationCenter.default
            nc.post(name: incomeNotification, object: nil)
        }
    }
}
