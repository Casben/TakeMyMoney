//
//  PaymentDataScreen.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/16/21.
//

import UIKit

class PaymentDataScreen: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var payPalEntryScreen: PayPalEntryScreen!
    @IBOutlet weak var creditEntryScreen: CreditEntryScreen!
    @IBOutlet weak var paymentControl: UISegmentedControl!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var paymentTotalLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    var payPalScreenOrigin: CGFloat = 0
    var creditScreenOrigin: CGFloat = 0
    private var isEditingPaypal = false
    private let segueIdentifier = "PaymentConfirmationSegue"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Configuration
    
    func configure() {
        payPalScreenOrigin = payPalEntryScreen.frame.origin.y
        creditScreenOrigin = creditEntryScreen.frame.origin.y
        creditEntryScreen.alpha = 0
        creditEntryScreen.isHidden = true
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        paymentControl.addTarget(self, action: #selector(segmentConrolToggled), for: .valueChanged)
        
        payPalEntryScreen.delegate = self
        creditEntryScreen.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: - Methods
    func animatePaymentScreens(hiding viewToBeHidden: UIView, showing viewToBeShown: UIView) {
        UIView.animate(withDuration: 0.75) {
            viewToBeShown.alpha = 1
            viewToBeHidden.alpha = 0
            viewToBeShown.isHidden = false
            viewToBeHidden.isHidden = true
            
        }
    }
    
    func disableBackgroundWhileEditing() {
        paymentControl.isEnabled = false
        totalPriceLabel.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    func restoreBackgroundAfterEditing() {
        paymentControl.isEnabled = true
        totalPriceLabel.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let navVC = segue.destination as! UINavigationController
            let paymentConfirmationVC = navVC.topViewController as! PaymentConfirmationScreenViewController
            paymentConfirmationVC.credentials = sender
            paymentConfirmationVC.delegate = self
        }
    }
    
    //MARK: - Actions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isEditingPaypal {
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= (keyboardSize.height - 250)
                }
            } else {
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= (keyboardSize.height - 175)
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
    
    @objc func segmentConrolToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            animatePaymentScreens(hiding: creditEntryScreen, showing: payPalEntryScreen)
        case 1:
            animatePaymentScreens(hiding: payPalEntryScreen, showing: creditEntryScreen)
        default:
            break
            
        }
    }
}

//MARK: - PayPalPaymentControlFlow

extension PaymentDataScreen: PayPalPaymentControlFlow {
    
    func disableBackgroundForPayPal() {
        disableBackgroundWhileEditing()
        isEditingPaypal = true
        
    }
    
    func proceedWithPayPal(withCredentials credentials: PayPalEntryViewModel) {
        print(credentials)
        performSegue(withIdentifier: segueIdentifier, sender: credentials)
    }
    
    
}

//MARK: - CreditPaymentControlFlow

extension PaymentDataScreen: CreditPaymentControlFlow {

    func disableBackgroundForCredit() {
        disableBackgroundWhileEditing()
        isEditingPaypal = false
    }
    
    func proceedWithCredit(withCredentials credentials: CreditEntryViewModel) {
        performSegue(withIdentifier: segueIdentifier, sender: credentials)
    }
}




extension PaymentDataScreen: PaymentConfirmationDelegate {
    func completePurchase() {
        let alertVC = UIAlertController(title: "Unable to complete purchase", message: "Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        action.setValue(UIColor.systemIndigo, forKey: "titleTextColor")
        alertVC.addAction(action)
        dismiss(animated: true) {
            self.present(alertVC, animated: true)
        }
    }
}
