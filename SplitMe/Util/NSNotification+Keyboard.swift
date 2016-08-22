//
//  NSNotification+Keyboard.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/6/16.
//
//

import Foundation
import UIKit

extension NSNotification {

    var keyboardAnimationDuration: NSTimeInterval? {
        return userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval
    }

    var keyboardEndFrame: CGRect? {
        return (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
    }


}