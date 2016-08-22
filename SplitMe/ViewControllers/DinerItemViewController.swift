//
//  DinerItemViewController.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation
import UIKit

class DinerItemViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var dinerNameContainer: UIView!
    @IBOutlet weak var dinerNameLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!

    @IBOutlet weak var appetizerButton: UIButton!
    @IBOutlet weak var entreeButton: UIButton!
    @IBOutlet weak var dessertButton: UIButton!
    @IBOutlet weak var drinkButton: UIButton!

    @IBOutlet weak var textEntryDoneButton: UIButton!
    @IBOutlet weak var dinerDoneButton: UIButton!
    @IBOutlet weak var nextItemButton: UIButton!

    // MARK: View related

    private lazy var buttonMapping: [MealItem.Kind : UIButton] = [
        .Appetizer: self.appetizerButton,
        .Entree: self.entreeButton,
        .Dessert: self.dessertButton,
        .Drink: self.drinkButton
    ]

    private lazy var priceFieldDelegate: PriceFieldDelegate = PriceFieldDelegate(textField: self.amountTextField)

    private var keyboardCoveringUI = false {
        didSet {
            textEntryDoneButton.alpha = keyboardCoveringUI ? 1 : 0
        }
    }

    // MARK: Data

    var meal: Meal?

    var itemType: MealItem.Kind? {
        didSet {
            for (type, button) in buttonMapping {
                button.borderWidth = (type == itemType) ? 4 : 0
            }
            nextItemButton.enabled = itemType != nil
        }
    }

    // MARK: Overrides

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        registerForKeyboardNotifications()
        amountTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dinerNameContainer.backgroundColor = meal?.currentDiner.color
        dinerDoneButton.backgroundColor = meal?.currentDiner.color
        [appetizerButton, entreeButton, dessertButton, drinkButton].forEach { $0.borderColor = meal?.currentDiner.color }
        nextItemButton.enabled = false

        amountTextField.delegate = priceFieldDelegate
    }


    // MARK: - Actions

    @IBAction func itemTypeSelected(sender: UIButton) {
        itemType = MealItem.Kind(rawValue: sender.tag)
    }

    @IBAction func editNameButtonTapped() {

    }

    @IBAction func textEntryDoneButtonTapped() {
        amountTextField.resignFirstResponder()
    }

    @IBAction func dinerDoneButtonTapped() {

    }

    @IBAction func backButtonTapped() {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func nextButtonTapped() {
        guard let type = itemType,
            let sb = storyboard,
            let vc = sb.instantiateViewControllerWithIdentifier("DinerItemViewController") as? DinerItemViewController
            else { return }

        meal?.currentDiner.addItem(MealItem(type: type, price: priceFieldDelegate.amount))
        vc.meal = meal
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Notifications

    override func keyboardWillAppear(notification: NSNotification) {
        guard let keyboardFrame = notification.keyboardEndFrame else { return }

        let dinerDoneFrame = dinerDoneButton.convertRect(dinerDoneButton.bounds, toView: view)
        keyboardCoveringUI = keyboardFrame.minY < dinerDoneFrame.maxY
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        keyboardCoveringUI = false
    }
    
}