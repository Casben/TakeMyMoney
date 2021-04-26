//
//  ConfirmButton.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/17/21.
//

import UIKit


class ConfirmButton: UIButton {

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        backgroundColor = .darkGray
    }
}
