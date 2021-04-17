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
    
    @IBOutlet weak var paymentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        creditEntryScreen.alpha = 0
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemIndigo], for: .selected)
    }
    
    
    @IBAction func segmentControlToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            animatePaymentScreens(hiding: creditEntryScreen, showing: payPalEntryScreen)
            
            
        case 1:
            animatePaymentScreens(hiding: payPalEntryScreen, showing: creditEntryScreen)
            
        default:
            break
            
        }
    }
    
    
    func animatePaymentScreens(hiding viewToBeHidden: UIView, showing viewToBeShown: UIView) {
        UIView.animate(withDuration: 0.6) {
            viewToBeHidden.alpha = 0
            viewToBeShown.alpha = 1
        }
    }
}
