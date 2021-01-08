//
//  Expense.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 08/01/21.
//

import Foundation

class Expense {
    
    var name: String
    var amount: Float
    var target: Date
    var isExecuted: Bool
    
    init(name: String, amount: Float, target: Date, isExecuted: Bool) {
        self.name = name
        self.amount = amount
        self.target = target
        self.isExecuted = isExecuted
    }
    
    func executeExpense(value: Bool, date: Date) -> (Float, Date) {
        
        if value {
            self.target = date
            self.isExecuted = true
            return (-self.amount, self.target)
        }
        return (self.amount, self.target)
    }
}
