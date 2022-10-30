//
//  EmailValidator.swift
//  Presentation
//
//  Created by Willian Guedes on 28/10/22.
//

import Foundation

protocol EmailValidator {
    func isValid(email: String) -> Bool
}
