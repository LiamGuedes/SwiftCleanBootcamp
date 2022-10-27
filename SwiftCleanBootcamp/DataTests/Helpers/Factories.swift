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

func makeEmptyData() -> Data {
    return Data()
}

func makeURL() -> URL {
    return URL(string: "https://www.google.com.br")!
}

func makeError() -> Error {
    return NSError(domain: "Unexpected Error", code: 123)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
