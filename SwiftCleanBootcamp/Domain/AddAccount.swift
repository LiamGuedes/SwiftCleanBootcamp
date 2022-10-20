//
//  AddAccount.swift
//  Domain
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completition: @escaping (Result<AccountModel, Error>) -> Void)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
