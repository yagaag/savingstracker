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
        NotificationCenter.default.addObserver(self, selector: #selector(reactToSavingsNotification(_:)), name: savingsNotification, object: nil)
        
        self.tableView.rowHeight = 70.0
        
        self.navigationItem.title = savingsNameList[savingsID]
        
        let (a, b) = getIncomes(id: savingsID)
        (executedIncome.text, totalIncome.text) = (String(a), String(b))
    }
    
    @IBAction func onAddIncome(_ sender: Any) {
        self.performSegue(withIdentifier: "addIncome", sender: self)
    }
    
    @IBAction func onSavingsPressed(_ sender: UIBarButtonItem) {
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addIncome" {
            let destinationVC = segue.destination as! AddIncomeController
            destinationVC.delegate = self
        }
    }
    
    func reactToAddIncome(actionType: String, name: String, amount: String, isExecuted: Bool) {
        if actionType == "Add" {
            incomeList[savingsID].append(Income(name: name, amount: Float(amount)!, isExpendable: true, target: Date(), isExecuted: isExecuted))
            // Notify to HomeController and self
            let nc = NotificationCenter.default
            nc.post(name: incomeNotification, object: nil)
        }
    }
    
    @objc func reactToIncomeNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getIncomes(id: savingsID)
        (executedIncome.text, totalIncome.text) = (String(a), String(b))
    }
    @objc func reactToSavingsNotification(_ sender: Notification) {
        self.tableView.reloadData()
        let (a, b) = getIncomes(id: savingsID)
        (self.executedIncome.text, self.totalIncome.text) = (String(a), String(b))
        self.navigationItem.title = savingsNameList[savingsID]
    }
}

func getIncomes(id: Int) -> (Float , Float) {
    var t1: Float = 0.0
    var t2: Float = 0.0
    for i in 0..<incomeList[id].count {
        if incomeList[id][i].isExecuted {
            t1 += incomeList[id][i].amount
        }
        else {
            t2 += incomeList[id][i].amount
        }
    }
    return (t1, t1+t2)
}

extension IncomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomeList[savingsID].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let income = incomeList[savingsID][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell") as! IncomeCell
        cell.selectionStyle = .none
        cell.setIncome(income: income)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if incomeList[savingsID][indexPath.row].isExecuted {
                savingsList[savingsID].amount -= incomeList[savingsID][indexPath.row].amount
            }
            incomeList[savingsID].remove(at: indexPath.row)
            // Notify to HomeController
            let nc = NotificationCenter.default
            nc.post(name: incomeNotification, object: nil)
        }
    }
}
