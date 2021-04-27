//
//  CreditEntryTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit


//MARK: - CreditPaymentControlFlow

protocol CreditPaymentControlFlow: class {
    func disableBackgroundForCredit()
    func proceedWithCredit(withCredentials credentials: CreditEntryViewModel)
}

class CreditEntryScreen: UIView {
    
    //MARK: - Properties
    
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
    private let expirationPicker = UIPickerView()
    private var editingResponder: UITextField?
    
    private var isCardHolderEntryValid = false
    
    weak var delegate: CreditPaymentControlFlow?

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    //MARK: - Configuration
    
    func configure() {
        layer.cornerRadius = 20
        creditCardTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        creditCardTextfield.addTarget(self, action: #selector(textdDidBegin), for: .editingDidBegin)
        expirationTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        expirationTextField.addTarget(self, action: #selector(textdDidBegin), for: .editingDidBegin)
        cvvTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cvvTextField.addTarget(self, action: #selector(textdDidBegin), for: .editingDidBegin)
        cardHolderTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cardHolderTextField.addTarget(self, action: #selector(textdDidBegin), for: .editingDidBegin)
        confirmPurchaseButton.addTarget(self, action: #selector(continueWithCredit), for: .touchUpInside)
        
        
        creditCardTextfield.delegate = self
        expirationTextField.delegate = self
        cvvTextField.delegate = self
        cardHolderTextField.delegate = self
        expirationPicker.delegate = self
        expirationPicker.dataSource = self
        expirationTextField.inputView = expirationPicker
        addDoneButtonToKeyboard()
    }
    

    //MARK: - Methods
    
    //Evaluates the forms status and wether or not to show errors or reset UI.
    func evaluateForm() {
        if viewModel.cardNumber == nil || viewModel.cardNumber?.isEmpty == true || viewModel.cardNumber?.count != 16 {
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
        if viewModel.cvv == nil || viewModel.cvv?.isEmpty == true || viewModel.cvv?.count != 3, viewModel.cvv?.count != 4 {
            cvvLabel.presentErrorMessage(withMessage: "Enter CVV.")
            cvvTextField.showError()
        } else {
            cvvLabel.resetLabelText()
            cvvTextField.resetField()
        }
        if viewModel.cardHolderName == nil || viewModel.cardHolderName?.isEmpty == true || !isCardHolderEntryValid {
            cardHolderLabel.presentErrorMessage(withMessage: "Enter card holder's name.")
            cardHolderTextField.showError()
        } else {
            cardHolderLabel.resetLabelText()
            cardHolderTextField.resetField()
        }
    }
    
    // Masks the creditCardTextField to hide the first 12 characters and show the remaining 4.
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
    
    // checks if the cardHolderName is longer than 4 characters and DOES NOT contain a space at the begining of the string. Second check makes sure that the string does contain a space but not a space at the end of the string.
    func checkIfCardHolderEntryIsValid() {
        if let validCardHolderName = viewModel.cardHolderName {
            if validCardHolderName.count >= 4 && validCardHolderName.first != " " {
                if validCardHolderName.contains(" ") && validCardHolderName.last != " " {
                    isCardHolderEntryValid = true
                }
            } else {
                isCardHolderEntryValid = false
            }
            viewModel.cardHolderName = validCardHolderName
        }
        
    }
    
    // adds a done button to the keyboard to make keyboard management as the UITextFieldDelegate method textFieldShouldReturn is not implemented.
    func addDoneButtonToKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        doneButton.tintColor = .systemIndigo
        
        let items = [flexSpace, doneButton]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        creditCardTextfield.inputAccessoryView = doneToolbar
        expirationTextField.inputAccessoryView = doneToolbar
        cvvTextField.inputAccessoryView = doneToolbar
        cardHolderTextField.inputAccessoryView = doneToolbar
        
    }
    
    //MARK: - Actions
    
    @objc func doneButtonAction() {
        editingResponder?.resignFirstResponder()
        editingResponder = nil
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        switch sender {
        case creditCardTextfield:
            viewModel.cardNumber = sender.text
            updateCreditCardTextField()
        case cvvTextField:
            viewModel.cvv = sender.text
        case cardHolderTextField:
            viewModel.cardHolderName = sender.text
            checkIfCardHolderEntryIsValid()
        default:
            break
        }
        if viewModel.cardNumber == nil && viewModel.expiration == nil && viewModel.cvv == nil && viewModel.cardHolderName == nil {
            evaluateForm()
        } else {
            checkFormStatus()
        }
    }
    
    
    @objc func textdDidBegin(_ sender: UITextField) {
        editingResponder = sender
        delegate?.disableBackgroundForCredit()
    }
    
   
    @objc func continueWithCredit() {
        if viewModel.formIsValid {
            if editingResponder != nil {
                editingResponder?.resignFirstResponder()
            }
            delegate?.proceedWithCredit(withCredentials: viewModel)
            viewModel.resetViewModel()
            resetTextFields(creditCardTextfield, expirationTextField, cvvTextField, cardHolderTextField)
            resetLabels(creditCardLabel, expirationLabel, cvvLabel, cardHolderLabel)
            confirmPurchaseButton.backgroundColor = .darkGray
            checkFormStatus()
        } else {
            evaluateForm()
        }
    }
}

//MARK: - AuthenticationControllerProtocol

extension CreditEntryScreen: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            confirmPurchaseButton.backgroundColor = .systemIndigo
        } else {
            confirmPurchaseButton.backgroundColor = .darkGray
        }
    }
}

//MARK: - UITextFieldDelgate

extension CreditEntryScreen: UITextFieldDelegate {
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
        
        if textField == cardHolderTextField {
            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet
        }
        return true
    }
}

//MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension CreditEntryScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExpirationPickerData.instance.monthsAndYears[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ExpirationPickerData.instance.monthsAndYears[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = ExpirationPickerData.instance.monthsAndYears[0][pickerView.selectedRow(inComponent: 0)]
        let year = ExpirationPickerData.instance.monthsAndYears[1][pickerView.selectedRow(inComponent: 1)]
        expirationTextField.text = "\(month)/\(year)"
        viewModel.expiration = expirationTextField.text
    }
}
