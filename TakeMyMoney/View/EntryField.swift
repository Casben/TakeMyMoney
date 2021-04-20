//
//  EntryField.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

class EntryField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        backgroundColor = .white
        textColor = .systemIndigo
    }

}
