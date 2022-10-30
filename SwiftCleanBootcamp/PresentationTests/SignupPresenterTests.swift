
//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Willian Guedes on 28/10/22.
//

import XCTest
@testable import Presentation

final class SignupPresenterTests: XCTestCase {
    func test_signup_should_show_error_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signup(viewmodel: self.makeSignupViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo nome e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signup(viewmodel:  self.makeSignupViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo email e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signup(viewmodel:  self.makeSignupViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo password e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signup(viewmodel:  self.makeSignupViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo confirmar senha e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_and_password_confirmation_are_differents() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signup(viewmodel:  self.makeSignupViewModel(password: "456"))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "As senhas devem coincidir"))
    }
    
    func test_signup_should_show_error_if_email_is_valid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        
        sut.signup(viewmodel:  self.makeSignupViewModel())
        XCTAssertEqual(emailValidatorSpy.email, self.makeSignupViewModel().email)
    }
    
    func test_signup_should_show_error_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        emailValidatorSpy.isValid = false
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "Email Invalido"))
    }
}

extension SignupPresenterTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignupPresenter {
        let sut = SignupPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    func makeSignupViewModel (name: String? = "willian", email: String? = "any@gmail.com", password: String? = "123", passwordConfirmation: String? = "123") -> SignupViewModel {
        return SignupViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewmodel: AlertViewModel) {
            self.viewModel = viewmodel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
    }
}
