//
//  HTTPError.swift
//  Data
//
//  Created by Willian Guedes on 21/10/22.
//

import Foundation

public enum HttpError: Error {
    case unexpected
    case noConnectivity
    case badRequest
    case serverError
    case unathorized
    case forbidden
}
