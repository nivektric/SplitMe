//
//  ItemType.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation

struct MealItem {

    enum Kind: Int {
        case Appetizer = 1
        case Entree = 2
        case Dessert = 3
        case Drink = 4
    }

    let type: Kind
    let price: NSDecimalNumber

}