//
//  AddAccount.swift
//  Domain
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completition: @escaping (Result<AccountModel, Error>) -> Void)
}

public struct AddAccountModel {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
}
