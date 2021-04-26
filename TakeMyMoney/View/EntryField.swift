//
//  EntryField.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class EntryField: UITextField {

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        backgroundColor = .white
        textColor = .systemIndigo
    }
    
    //MARK: - Methods
    
    func showError() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }
    
    func resetField() {
        layer.borderWidth = 0
    }

}
