//
//  PaymentConfirmationScreenViewController.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/26/21.
//

import UIKit

class PaymentConfirmationScreenViewController: UIViewController {

    @IBOutlet weak var couponImageView: UIImageView!
    @IBOutlet weak var paymentInfoView: UIView!
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var credentialsImageView: UIImageView!
    @IBOutlet weak var credentialsSubLabel: UILabel!
    @IBOutlet weak var credentialsLabel: UILabel!
    var credentials: Any!
    private var payPalCredentials: PayPalEntryViewModel?
    private var creditCredentials: CreditEntryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCredentials()
        configure()
    }
    
    func configure() {
        couponImageView.layer.cornerRadius = 10
        paymentInfoView.layer.cornerRadius = 10
        payButton.layer.cornerRadius = 10
    }
    
    func prepareCredentials() {
        switch credentials {
        case is PayPalEntryViewModel:
            payPalCredentials = credentials as? PayPalEntryViewModel
            configureUIForPayPal()
        case is CreditEntryViewModel:
            creditCredentials = credentials as? CreditEntryViewModel
            configureUIForCredit()
        default:
            break
        }
    }
    
    func configureUIForPayPal() {
        credentialsImageView.image = #imageLiteral(resourceName: "PayPalLogo")
        credentialsSubLabel.text = "Account:"
        credentialsLabel.text = payPalCredentials?.email
    }
    
    func configureUIForCredit() {
        credentialsImageView.image = #imageLiteral(resourceName: "mastercard")
        credentialsSubLabel.text = "Card Number:"
        credentialsLabel.text = creditCredentials?.cardNumber
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
