//
//  DataExtensions.swift
//  Data
//
//  Created by Willian Guedes on 22/10/22.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
