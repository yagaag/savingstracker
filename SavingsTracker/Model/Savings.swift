//
//  Savings.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 08/01/21.
//

import Foundation

class Savings {
    
    var name: String
    var amount: Float
    
    init(name: String, amount: Float) {
        self.name = name
        self.amount = amount
    }
}

class monthlySavings: Savings {
    
    var subName: String
    var target: Date
    
    init(name: String, amount: Float, subName: String, target: Date) {
        self.subName = subName
        self.target = target
        super.init(name: name, amount: amount)
    }
}

var savings0 = Savings(name: "My Savings", amount: 10000)
var savings1 = Savings(name: "My Savings", amount: 10000)
var savings2 = Savings(name: "My Savings", amount: 10000)

var savingsList: Array<Savings> = [savings0, savings1, savings2]
