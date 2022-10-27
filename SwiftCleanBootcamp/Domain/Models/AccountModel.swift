//
//  AccountModel.swift
//  Domain
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

public struct AccountModel: BaseModel {
    public var accessToken: String
    public var name: String
    
    public init(id: String, name: String, email: String, password: String) {
        self.accessToken = id
        self.name = name
    }
}
