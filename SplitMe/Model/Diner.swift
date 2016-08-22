//
//  Diner.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation
import UIKit

class Diner {

    static let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        return formatter
    }()

    let saturation: CGFloat = 0.71
    let brightness: CGFloat = 0.44

    let id: UInt
    var name: String?
    private(set) var items = [MealItem]()

    var color: UIColor {
        // Magic formula stolen from earlier version
        let hue: CGFloat = (212 + 126 * CGFloat(id)) % 360

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    var displayName: String {
        return name ?? defaultName
    }

    private var defaultName: String {
        return "Diner \(Diner.numberFormatter.stringFromNumber(id)?.capitalizedString ?? "")"
    }

    init(id: UInt) {
        self.id = id
    }

    func addItem(item: MealItem) {
        items.append(item)
    }

}