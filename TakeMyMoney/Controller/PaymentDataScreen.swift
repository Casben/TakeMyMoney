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
    var payPalTableVC: PayPalLoginTableVC!
    var creditTableVC: CreditEntryTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        creditEntryScreen.alpha = 0
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        paymentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let payPalTableVC = segue.destination as? PayPalLoginTableVC, segue.identifier == "PayPalSegue" {
            self.payPalTableVC = payPalTableVC
            payPalTableVC.delegate = self
        } else if let creditTableVC = segue.destination as? CreditEntryTableVC, segue.identifier == "CreditSegue" {
            creditTableVC.delegate = self
        }
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
        UIView.animate(withDuration: 0.5) {
            viewToBeShown.alpha = 1
            viewToBeHidden.alpha = 0
            
        }
    }
}

extension PaymentDataScreen: PaymentControlFlow {
    func disableBackgroundViewWhileEditing(_ view: UIView) {
//        view.bringSubviewToFront(creditEntryScreen)
        print("delegate")
        paymentControl.alpha = 0
        navigationController?.navigationBar.isHidden = true
    }
}
