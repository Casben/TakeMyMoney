//
//  ConfirmButton.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit

@IBDesignable
class ConfirmButton: UIButton {

    override func prepareForInterfaceBuilder() {
        layer.cornerRadius = 4
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        backgroundColor = .darkGray
    }

}
