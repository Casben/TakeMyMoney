//
//  PaymentDataScreen.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/16/21.
//

import UIKit

class PaymentDataScreen: UIViewController {

    @IBOutlet weak var payPalEntryScreen: UIView!
    @IBOutlet weak var creditEntryScreen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure() {
        
    }


    @IBAction func segmentControlToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
//            creditEntryScreen.isHidden = true
//            payPalEntryScreen.isHidden = false
        animatePaymentScreens(hiding: creditEntryScreen, showing: payPalEntryScreen)
            
        case 1:
//            payPalEntryScreen.isHidden = true
//            creditEntryScreen.isHidden = false
        animatePaymentScreens(hiding: payPalEntryScreen, showing: creditEntryScreen)
        default:
            break
            
        }
    }
    
    func animatePaymentScreens(hiding viewToBeHidden: UIView, showing viewToBeShown: UIView) {
        UIView.animate(withDuration: 1.3) {
            viewToBeHidden.alpha = 0
            viewToBeShown.alpha = 1
        }
    }
}
