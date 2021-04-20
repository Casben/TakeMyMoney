//
//  CreditEntryTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class CreditEntryTableVC: UITableViewController {
    
    @IBOutlet weak var creditCardLabel: EntryLabel!
    @IBOutlet weak var expirationLabel: EntryLabel!
    @IBOutlet weak var cvvLabel: EntryLabel!
    @IBOutlet weak var cardHolderLabel: EntryLabel!
    
    @IBOutlet weak var creditCardTextfield: EntryField!
    @IBOutlet weak var expirationTextField: EntryField!
    @IBOutlet weak var cvvTextField: EntryField!
    @IBOutlet weak var cardHolderTextField: EntryField!
    @IBOutlet weak var confirmPurchaseButton: ConfirmButton!
    
    private var viewModel = CreditEntryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        tableView.layer.cornerRadius = 20
        creditCardTextfield.delegate = self
        creditCardTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        expirationTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cvvTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cardHolderTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        creditCardTextfield.delegate = self
        expirationTextField.delegate = self
        cvvTextField.delegate = self
        cardHolderTextField.delegate = self
    }
    
    func evaluateForm() {
        if viewModel.cardNumber == nil || viewModel.cardNumber?.isEmpty == true {
            creditCardLabel.presentErrorMessage(withMessage: "Enter a valid credit card number.")
            creditCardTextfield.showError()
        } else {
            creditCardLabel.resetLabelText()
            creditCardTextfield.resetField()
        }
        if viewModel.expiration == nil || viewModel.expiration?.isEmpty == true {
            expirationLabel.presentErrorMessage(withMessage: "Enter a month & year.")
            expirationTextField.showError()
        } else {
            expirationLabel.resetLabelText()
            expirationTextField.resetField()
        }
        if viewModel.cvv == nil || viewModel.cvv?.isEmpty == true {
            cvvLabel.presentErrorMessage(withMessage: "Enter CVV.")
            cvvTextField.showError()
        } else {
            cvvLabel.resetLabelText()
            cvvTextField.resetField()
        }
        if viewModel.cardHolderName == nil || viewModel.cardHolderName?.isEmpty == true {
            cardHolderLabel.presentErrorMessage(withMessage: "Enter card holder's name.")
            cardHolderTextField.showError()
        } else {
            cardHolderLabel.resetLabelText()
            cardHolderTextField.resetField()
        }
    }
    
    func updateCreditCardTextField() {
        guard let creditFieldText = creditCardTextfield.text else {return}
        if creditFieldText.count <= 12 {
            for char in creditFieldText {
                let index = String(char)
                creditCardTextfield.text?.remove(at: index.startIndex)
                creditCardTextfield.text?.append("•")
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        switch sender {
        case creditCardTextfield:
            viewModel.cardNumber = sender.text
            updateCreditCardTextField()
        case expirationTextField:
            viewModel.expiration = sender.text
        case cvvTextField:
            viewModel.cvv = sender.text
        case cardHolderTextField:
            viewModel.cardHolderName = sender.text
        default:
            break
        }
        if viewModel.cardNumber == nil && viewModel.expiration == nil && viewModel.cvv == nil && viewModel.cardHolderName == nil {
            evaluateForm()
        } else {
            checkFormStatus()
        }
    }
    
    
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        evaluateForm()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension CreditEntryTableVC: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            confirmPurchaseButton.backgroundColor = .systemIndigo
        } else {
            confirmPurchaseButton.backgroundColor = .darkGray
        }
    }
}

extension CreditEntryTableVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == creditCardTextfield {
            let currentCount = textField.text?.count ?? 0
            if range.length + range.location > currentCount {
                return true
            }
            
            let newLength = currentCount + string.count - range.length
            return newLength <= 16
        } else if textField == cvvTextField {
            let currentCount = textField.text?.count ?? 0
            if range.length + range.location > currentCount {
                return true
            }
            
            let newLength = currentCount + string.count - range.length
            return newLength <= 4
        }
        
        return false
        
    }

    
}
