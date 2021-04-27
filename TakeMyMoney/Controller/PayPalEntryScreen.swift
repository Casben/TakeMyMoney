//
//  PayPalSignInTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

//MARK: - PayPalPaymentControlFlow

protocol PayPalPaymentControlFlow: class {
    func disableBackgroundForPayPal()
    func proceedWithPayPal(withCredentials credentials: PayPalEntryViewModel)
}

class PayPalEntryScreen: UIView {

    //MARK: - Properties
    
    @IBOutlet weak var emailTextfield: EntryField!
    @IBOutlet weak var passwordTextField: EntryField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel = PayPalEntryViewModel()
    weak var delegate: PayPalPaymentControlFlow?
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    //MARK: - Configuration
    
    func configure() {
        layer.cornerRadius = 20
        signInButton.isEnabled = false
        
        signInButton.addTarget(self, action: #selector(continueWithPayPal), for: .touchUpInside)
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextfield.addTarget(self, action: #selector(textDidBegin), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidBegin), for: .editingDidBegin)
        emailTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    
    //MARK: - Actions
    
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
    
    @objc func continueWithPayPal() {
        if emailTextfield.isFirstResponder {
            emailTextfield.resignFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        delegate?.proceedWithPayPal(withCredentials: viewModel)
        viewModel.resetViewModel()
        resetTextFields(emailTextfield, passwordTextField)
        checkFormStatus()
    }

}

//MARK: - AuthenticationControllerProtocol

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

//MARK: - UITextFieldDelegate

extension PayPalEntryScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
