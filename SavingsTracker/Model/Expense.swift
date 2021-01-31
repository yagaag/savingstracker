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

var expenses: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 2000, target: Date(), isExecuted: false)]
var expenses1: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 2000, target: Date(), isExecuted: false)]
var expenses2: Array<Expense> = [Expense(name: "Car", amount: 1000, target: Date(), isExecuted: false), Expense(name: "Bike", amount: 2000, target: Date(), isExecuted: false)]

var expenseList: Array<Array<Expense>> = [expenses, expenses1, expenses2]
