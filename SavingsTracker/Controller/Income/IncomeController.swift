//
//  IncomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 12/01/21.
//

import UIKit

class IncomeController: UIViewController, UINavigationControllerDelegate, AddIncomeControllerDelegate {
    
    var incomes: Array<Income> = [Income(name: "Barath", amount: 3000, isExpendable: true, target: Date(), isExecuted: false), Income(name: "Sneha", amount: 10000, isExpendable: true, target: Date(), isExecuted: false)]
    
    
    @IBOutlet weak var executedIncome: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Income"
        self.tableView.rowHeight = 70.0
        
        (executedIncome.text, totalIncome.text) = getIncomes()
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
    
    func reactToAddIncome(actionType: String, name: String, amount: String) {
        print("\(actionType), \(name), \(amount)")
    }
    
    func getIncomes() -> (String, String) {
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
        return (String(t1), String(t1+t2))
    }
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
}
