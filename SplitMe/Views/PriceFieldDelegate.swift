//
//  PriceFieldDelegate.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/5/16.
//
//

import Foundation
import UIKit

class PriceFieldDelegate: NSObject, UITextFieldDelegate {

    weak var textField: UITextField?

    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter
    }()

    init(textField: UITextField) {
        self.textField = textField
        textField.text = numberFormatter.stringFromNumber(amount)
    }

    var amount: NSDecimalNumber = 0 {
        didSet {
            textField?.text = numberFormatter.stringFromNumber(amount)
        }
    }

    var cents: UInt {
        get {
            return UInt(amount.decimalNumberByMultiplyingBy(NSDecimalNumber(int: 100)))
        }
        set {
            amount = NSDecimalNumber(unsignedLong: newValue).decimalNumberByDividingBy(NSDecimalNumber(int: 100))
        }
    }

    // MARK: - UITextFieldDelegate

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        // Backspace
        if string.isEmpty {
            var numString = String(cents)
            if numString.characters.count > 0 {
                numString = numString.substringToIndex(numString.startIndex.advancedBy(numString.characters.count-1))
                cents = UInt(numString) ?? 0
            }
        } else {
            cents = UInt(String(cents) + string) ?? 0
        }


        return false
    }
    
}