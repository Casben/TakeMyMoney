//
//  EntryLabel.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/20/21.
//

import UIKit

class EntryLabel: UILabel {
    
    final var originalLabelText: String!
    final var originalTextColor: UIColor!

    override func awakeFromNib() {
        super.awakeFromNib()
        font.withSize(17)
        originalLabelText = text
        originalTextColor = textColor
    }
    
    
    func presentErrorMessage(withMessage message: String) {
        text = message
        textColor = .red
    }
    
    func resetLabelText() {
        text = originalLabelText
        textColor = originalTextColor
    }

}
