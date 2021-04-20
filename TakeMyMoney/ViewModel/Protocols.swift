//
//  Protocols.swift
//  TakeMyMoney
//
//  Created by Herbert Dodge on 4/19/21.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

protocol AuthenticationDelegate: class {
    func authenticationComplete()
}
