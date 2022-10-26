//
//  Factories.swift
//  DataTests
//
//  Created by Willian Guedes on 22/10/22.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Willian\"}".utf8)
}

func makeURL() -> URL {
    return URL(string: "https://www.google.com.br")!
}

func makeError() -> Error {
    return NSError(domain: "Unexpected Error", code: 123)
}
