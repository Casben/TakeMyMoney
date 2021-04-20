//
//  CreditEntryViewModel.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/19/21.
//

import Foundation

struct PayPalEntryViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
