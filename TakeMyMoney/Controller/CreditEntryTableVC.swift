//
//  CreditEntryTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class CreditEntryTableVC: UITableViewController {
    
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var cvvLabel: UILabel!
    @IBOutlet weak var cardHolderLabel: UILabel!
    
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
        creditCardTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        expirationTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cvvTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        cardHolderTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func evaluateForm() {
//        if viewModel.cardNumber == nil || viewModel.cardNumber?.isEmpty == true {
//            creditCardLabel.text = "Please enter a valid credit card number."
//            creditCardLabel.textColor = .red
//            creditCardTextfield.layer.borderWidth = 1
//            creditCardTextfield.layer.borderColor = UIColor.red.cgColor
//            print("cardfield")
//        } else if viewModel.expiration == nil || viewModel.expiration?.isEmpty == true {
//            expirationLabel.text = "Please enter a month & year."
//            expirationLabel.textColor = .red
//            expirationTextField.layer.borderWidth = 1
//            expirationTextField.layer.borderColor = UIColor.red.cgColor
//        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        switch sender {
        case creditCardTextfield:
            viewModel.cardNumber = sender.text
        case expirationTextField:
            viewModel.expiration = sender.text
        case cvvTextField:
            viewModel.cvv = sender.text
        case cardHolderTextField:
            viewModel.cardHolderName = sender.text
        default:
            break
        }
//        checkFormStatus()
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        checkFormStatus()
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
            evaluateForm()
        }
    }
}
