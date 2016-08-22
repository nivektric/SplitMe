//
//  UIViewController+Keyboard.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation
import UIKit

protocol KeyboardAware {

    func keyboardWillAppear(notification: NSNotification)

    func keyboardWillHide(notification: NSNotification)

}

extension UIViewController: KeyboardAware {

    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardWillAppear),
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardWillHide),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }

    func keyboardWillAppear(notification: NSNotification) {

    }

    func keyboardWillHide(notification: NSNotification) {

    }

}