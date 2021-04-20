//
//  CreditEntryViewModel.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/19/21.
//

import Foundation

struct CreditEntryViewModel: AuthenticationProtocol {
    var cardNumber: String?
    var expiration: String?
    var cvv: String?
    var cardHolderName: String?
    
    var formIsValid: Bool {
        return cardNumber?.isEmpty == false && expiration?.isEmpty == false && cvv?.isEmpty == false && cardHolderName?.isEmpty == false
    }
    
    
}
