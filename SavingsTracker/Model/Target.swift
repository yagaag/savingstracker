//
//  Target.swift
//  SavingsTracker
//
//  Created by yagaa-pt3544 on 08/01/21.
//

import Foundation

class Target {
    
    var name: String
    var amount: Float
    var date: Date
    
    init(name: String, amount: Float, date: Date) {
        self.name = name
        self.amount = amount
        self.date = date
    }
}
