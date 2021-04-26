//
//  PaymentDataScreen.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/16/21.
//

import UIKit

class PaymentDataScreen: UIViewController {

    @IBOutlet weak var payPalEntryScreen: PayPalEntryScreen!
    @IBOutlet weak var creditEntryScreen: CreditEntryScreen!
    @IBOutlet weak var paymentControl: UISegmentedControl!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var paymentTotalLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    var payPalScreenOrigin: CGFloat = 0
    var creditScreenOrigin: CGFloat = 0
    private var isEditingPaypal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        payPalScreenOrigin = payPalEntryScreen.frame.origin.y
        creditScreenOrigin = creditEntryScreen.frame.origin.y
        creditEntryScreen.alpha = 0
        creditEntryScreen.isHidden = true
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        payPalEntryScreen.delegate = self
        creditEntryScreen.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isEditingPaypal {
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= (keyboardSize.height - 250)
                }
            } else {
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= (keyboardSize.height - 110)
                }
            }
        }
        
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
        restoreBackgroundAfterEditing()

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
    
    func disableBackgroundWhileEditing() {
        paymentControl.isHidden = true
        totalPriceLabel.isHidden = true
        paymentTotalLabel.isHidden = true
        paymentMethodLabel.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    func restoreBackgroundAfterEditing() {
        paymentControl.isHidden = false
        totalPriceLabel.isHidden = false
        paymentTotalLabel.isHidden = false
        paymentMethodLabel.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
}



extension PaymentDataScreen: PayPalPaymentControlFlow {
    func disableBackgroundForPayPal() {
        disableBackgroundWhileEditing()
        isEditingPaypal = true
        print("paypal called")
    }
    
    
}

extension PaymentDataScreen: CreditPaymentControlFlow {
    func disableBackgroundForCredit() {
        disableBackgroundWhileEditing()
        isEditingPaypal = false
        payPalEntryScreen.isHidden = true
        print("credit called")
    }
}




