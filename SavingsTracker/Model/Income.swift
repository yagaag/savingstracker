//
//  Income.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 08/01/21.
//

import Foundation

//enum schudledIncomeModes: String {
//    case monthStart, monthEnd
//}

class Income {
    
    var name: String
    var amount: Float
    var isExpendable: Bool
    var target: Date
    var isExecuted: Bool
    
    init(name: String, amount: Float, isExpendable: Bool, target: Date, isExecuted: Bool) {
        self.name = name
        self.amount = amount
        self.isExpendable = isExpendable
        self.target = target
        self.isExecuted = isExecuted
    }
    
//    func editIncome(category: String, value: String) {
//        switch category {
//        case "name":
//            self.name = value
//        case "amount":
//            self.amount = Float(value)!
//        case "isExpendable":
//            if value == "True" {
//                self.isExpendable = true
//            }
//            else {
//                self.isExpendable = false
//            }
//        default:
//            self.name = value
//        }
//    }
    
    func executeIncome(date: Date, value: Bool) -> (Float, Date) {
    
        if value {
            self.target = date
            self.isExecuted = true
            return (self.amount, self.target)
        }
        return (-self.amount, self.target)
    }
}
