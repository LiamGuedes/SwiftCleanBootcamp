//
//  BaseModel.swift
//  Domain
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

public protocol BaseModel: Codable, Equatable {}

public extension BaseModel {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
