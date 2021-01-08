//
//  HomeController.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 09/01/21.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var savingsAmount: UILabel!
    @IBOutlet weak var targetAmount: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var executeIncome: UIButton!
    @IBOutlet weak var executeExpense: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//if sender.backgroundColor == .clear {
//    sender.setTitleColor(.white, for: .normal)
//    sender.backgroundColor = .systemBlue
//}
//else {
//    sender.setTitleColor(.systemBlue, for: .normal)
//    sender.backgroundColor = .clear
//}
