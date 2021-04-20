//
//  Extensions.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/20/21.
//

import Foundation

extension String {
    var containsWhiteSpace: Bool {
        return (self.rangeOfCharacter(from: .whitespaces) != nil)
    }
}
