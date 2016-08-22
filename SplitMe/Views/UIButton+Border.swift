//
//  BorderedButton.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(CGColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

}