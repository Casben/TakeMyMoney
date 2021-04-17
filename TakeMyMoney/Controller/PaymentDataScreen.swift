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
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var paymentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        confirmButton.layer.cornerRadius = 10
        creditEntryScreen.alpha = 0
    }
    
    
    @IBAction func segmentControlToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            animatePaymentScreens(hiding: creditEntryScreen, showing: payPalEntryScreen, configureButton: "Sign In")
            
            
        case 1:
            animatePaymentScreens(hiding: payPalEntryScreen, showing: creditEntryScreen, configureButton: "Continue with Credit")
            
        default:
            break
            
        }
    }
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        switch paymentControl.selectedSegmentIndex {
        case 0:
            print("paypal")
        case 1:
            print("credit")
        default:
            break
        }
    }
    
    func animatePaymentScreens(hiding viewToBeHidden: UIView, showing viewToBeShown: UIView, configureButton title: String) {
        UIView.animate(withDuration: 0.8) {
            viewToBeHidden.alpha = 0
            viewToBeShown.alpha = 1
            self.confirmButton.setTitle(title, for: .normal)
        }
    }
}
