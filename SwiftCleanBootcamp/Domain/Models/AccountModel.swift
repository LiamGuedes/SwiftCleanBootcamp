//
//  AccountModel.swift
//  Domain
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

public struct AccountModel: BaseModel {
    public var id: String
    public var name: String
    public var email: String
    public var password: String
    
    public init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
