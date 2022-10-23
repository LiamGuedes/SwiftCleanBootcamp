//
//  AccountModelSeed.swift
//  DataTests
//
//  Created by Willian Guedes on 22/10/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "id_123" , name: "any", email: "any@mail.com", password: "123")
}
