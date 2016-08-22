//
//  Meal.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/6/16.
//
//

import Foundation

class Meal {

    var price: NSDecimalNumber
    var currentIndex: Int = 0
    var diners: [Diner] = []
    var currentDiner: Diner {
        return diners[currentIndex]
    }

    init(count: UInt, price: NSDecimalNumber) {
        for i in 0..<count {
            diners.append(Diner(id: i+1))
        }
        self.price = price
    }

}