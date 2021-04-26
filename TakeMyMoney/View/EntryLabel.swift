//
//  EntryLabel.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/20/21.
//

import UIKit

class EntryLabel: UILabel {
    
    //MARK: - Properties
    
    final var originalLabelText: String!
    final var originalTextColor: UIColor!

    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font.withSize(17)
        originalLabelText = text
        originalTextColor = textColor
    }
    
    
    //MARK: - Methods
    
    func presentErrorMessage(withMessage message: String) {
        text = message
        textColor = .red
    }
    
    func resetLabelText() {
        text = originalLabelText
        textColor = originalTextColor
    }

}
