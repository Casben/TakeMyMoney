//
//  PayPalSignInTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

protocol PayPalPaymentControlFlow: class {
    func disableBackgroundForPayPal()
}

class PayPalEntryScreen: UIView {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel = PayPalEntryViewModel()
    weak var delegate: PayPalPaymentControlFlow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 20
        signInButton.isEnabled = false
        
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextfield.addTarget(self, action: #selector(textDidBegin), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidBegin), for: .editingDidBegin)
        emailTextfield.delegate = self
        passwordTextField.delegate = self
        
        
        
        
    }
    
    
    
    @objc func textDidChange(_ sender: UITextField) {
        switch sender {
        case emailTextfield:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        default:
            break
        }
        checkFormStatus()
    }
    
    @objc func textDidBegin(_ sender: UITextField) {
        delegate?.disableBackgroundForPayPal()
    }

}

extension PayPalEntryScreen: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signInButton.isEnabled = true
            signInButton.backgroundColor = .systemIndigo
        } else {
            signInButton.isEnabled = false
            signInButton.backgroundColor = .darkGray
        }
    }
}

extension PayPalEntryScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
