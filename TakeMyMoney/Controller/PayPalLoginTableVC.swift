//
//  PayPalSignInTableVC.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class PayPalLoginTableVC: UITableViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel = PayPalEntryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        tableView.layer.cornerRadius = 20
        signInButton.isEnabled = false
        
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func textDidChange(sender: UITextField) {
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

}

extension PayPalLoginTableVC: AuthenticationControllerProtocol {
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
