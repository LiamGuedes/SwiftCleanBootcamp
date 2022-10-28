
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
        let (alertViewSpy, sut, _) = makeSut()
        let signupViewModel = SignupViewModel(email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo nome e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_email_is_not_provided() {
        let (alertViewSpy, sut, _) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo email e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_is_not_provided() {
        let (alertViewSpy, sut, _) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo password e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_confirmation_is_not_provided() {
        let (alertViewSpy, sut, _) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo confirmar senha e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_and_password_confirmation_are_differents() {
        let (alertViewSpy, sut, _) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123", passwordConfirmation: "456")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "As senhas devem coincidir"))
    }
    
    func test_signup_should_show_error_if_email_is_valid() {
        let (_, sut, emailValidatorSpy) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signupViewModel.email)
    }
    
    func test_signup_should_show_error_if_invalid_email_is_provided() {
        let (alertViewSpy, sut, emailValidatorSpy) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        emailValidatorSpy.isValid = false
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "Email Invalido"))
    }
}

extension SignupPresenterTests {
    
    func makeSut() -> (AlertViewSpy, SignupPresenter, EmailValidatorSpy) {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignupPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (alertViewSpy, sut, emailValidatorSpy)
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
