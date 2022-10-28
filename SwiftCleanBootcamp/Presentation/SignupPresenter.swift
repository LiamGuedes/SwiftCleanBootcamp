//
//  SignupPresenter.swift
//  Presentation
//
//  Created by Willian Guedes on 28/10/22.
//

import Foundation

struct SignupViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

final class SignupPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    init(alertView: AlertView, emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    func signup(viewmodel: SignupViewModel) {
        if let message = validateData(viewmodel: viewmodel) {
            alertView.showMessage(viewmodel: AlertViewModel(title: "Falha na Validacao", message:message))
        }
    }
    
    private func validateData(viewmodel: SignupViewModel) -> String? {
        if viewmodel.name == nil || viewmodel.name!.isEmpty {
            return "O campo nome e obrigatorio"
        } else if viewmodel.email == nil || viewmodel.email!.isEmpty {
            return "O campo email e obrigatorio"
        } else if viewmodel.password == nil || viewmodel.password!.isEmpty {
            return "O campo password e obrigatorio"
        } else if viewmodel.passwordConfirmation == nil || viewmodel.passwordConfirmation!.isEmpty {
            return "O campo confirmar senha e obrigatorio"
        } else if viewmodel.password != viewmodel.passwordConfirmation {
            return "As senhas devem coincidir"
        } else if !(emailValidator.isValid(email: viewmodel.email!)) {
            return "Email Invalido"
        }
        
        return nil
    }
}
