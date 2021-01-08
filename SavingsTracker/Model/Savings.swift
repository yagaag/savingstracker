//
//  Savings.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 08/01/21.
//

import Foundation

class Savings {
    
    var name: String
    var expendableAmount: Float
    var inexpendableAmount: Float
    var totalAmount: Float
    
    init(name: String, expendableAmount: Float, inexpendableAmount: Float) {
        self.name = name
        self.expendableAmount = expendableAmount
        self.inexpendableAmount = inexpendableAmount
        self.totalAmount = self.expendableAmount + self.inexpendableAmount
    }
}

class monthlySavings: Savings {
    
    var subName: String
    var target: Date
    
    init(name: String, expendableAmount: Float, inexpendableAmount: Float, subName: String, target: Date) {
        self.subName = subName
        self.target = target
        super.init(name: name, expendableAmount: expendableAmount, inexpendableAmount: inexpendableAmount)
    }
}
