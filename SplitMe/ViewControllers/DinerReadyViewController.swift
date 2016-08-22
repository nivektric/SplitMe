//
//  DinerReadyViewController.swift
//  SplitMe
//
//  Created by Kevin Monahan on 8/7/16.
//
//

import Foundation
import UIKit

class DinerReadyViewController: UIViewController {

    @IBOutlet weak var dinerNameLabel: UILabel!

    var meal: Meal?
    var diner: Diner? {
        return meal?.currentDiner
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dinerNameLabel.text = diner?.displayName
        dinerNameLabel.backgroundColor = diner?.color
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vc = segue.destinationViewController as? DinerItemViewController else { return }

        vc.meal = self.meal
    }

}