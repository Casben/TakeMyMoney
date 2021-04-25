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
    @IBOutlet weak var paymentLabel: UILabel!
    var payPalTableVC: PayPalEntryScreen!
    var creditTableVC: CreditEntryScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        creditEntryScreen.alpha = 0
        creditEntryScreen.isHidden = true
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
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
        UIView.animate(withDuration: 0.75) {
            viewToBeShown.alpha = 1
            viewToBeHidden.alpha = 0
            viewToBeShown.isHidden = false
            viewToBeHidden.isHidden = true
            
        }
    }
}

extension PaymentDataScreen: PayPalPaymentControlFlow {
    func disableBackgroundForPayPal() {
        creditEntryScreen.isHidden = true
        print("paypal called")
    }
    
    
}

extension PaymentDataScreen: CreditPaymentControlFlow {
    func disableBackgroundForCredit() {
        payPalEntryScreen.isHidden = true
        print("credit called")
    }
}




