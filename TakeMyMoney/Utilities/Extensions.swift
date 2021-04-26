//
//  Extensions.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/20/21.
//

import UIKit

extension String {
    var containsWhiteSpace: Bool {
        return (self.rangeOfCharacter(from: .whitespaces) != nil)
    }
}

extension UIView {
    func resetTextFields(_ textfields: EntryField...) {
        for textfield in textfields {
            textfield.text = ""
            textfield.resetField()
        }
    }
    func resetLabels(_ labels: EntryLabel...) {
        for label in labels {
            label.resetLabelText()
        }
    }
}
