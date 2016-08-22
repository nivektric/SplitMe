//
//  TotalAmountViewController.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/5/16.
//
//

import Foundation
import UIKit

class TotalAmountViewController: UIViewController {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dinerCountLabel: UILabel!
    @IBOutlet weak var dinerCountSection: UIView!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!

    private lazy var priceFieldDelegate: PriceFieldDelegate = PriceFieldDelegate(textField: self.priceTextField)

    private let maxDiners: UInt = 20
    private let minDiners: UInt = 2

    private var dinerCount: UInt = 0 {
        didSet {
            dinerCountLabel.text = String(dinerCount)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dinerCount = minDiners

        priceTextField.delegate = priceFieldDelegate

        registerForKeyboardNotifications()
    }

    // MARK: - Actions

    @IBAction func backButtonTapped() {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneButtonTapped() {
        priceTextField.resignFirstResponder()
    }

    @IBAction func nextButtonTapped() {
        performSegueForDinerOne()
    }

    @IBAction func incrementDiners(sender: AnyObject) {
        if dinerCount < maxDiners {
            dinerCount += 1
        }
    }

    @IBAction func decrementDiners(sender: AnyObject) {
        if dinerCount > minDiners {
            dinerCount -= 1
        }
    }

    // MARK: - Helpers

    private let overviewIdentifier = "OverviewViewController"
    private let dinerReadyIdentifier = "DinerReadyViewController"

    func performSegueForDinerOne() {
        guard let sb = self.storyboard,
            let overviewVC = sb.instantiateViewControllerWithIdentifier(overviewIdentifier) as? OverviewViewController,
            let readyVC = sb.instantiateViewControllerWithIdentifier(dinerReadyIdentifier) as? DinerReadyViewController
        else {
            return
        }

        readyVC.meal = Meal(count: dinerCount, price: priceFieldDelegate.amount)
        navigationController?.setViewControllers([overviewVC, readyVC], animated: true)
    }


    // MARK: - Notifications

    let keyboardBufferHeight: CGFloat = 12

    override func keyboardWillAppear(notification: NSNotification) {
        guard
            let duration = notification.keyboardAnimationDuration,
            let frame = notification.keyboardEndFrame
            else { return }


        let rect = priceTextField.convertRect(priceTextField.bounds, toView: view)
        let diff = rect.maxY - frame.minY + keyboardBufferHeight
        let transform = diff > 0 ? diff : 0

        UIView.animateWithDuration(duration) {
            self.view.transform = CGAffineTransformMakeTranslation(0, -transform)
            self.doneButton.alpha = 1
        }
        
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        guard
            let duration = notification.keyboardAnimationDuration
            else { return }

        UIView.animateWithDuration(duration) { 
            self.view.transform = CGAffineTransformIdentity
            self.doneButton.alpha = 0
        }

    }
    
}