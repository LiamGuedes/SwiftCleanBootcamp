
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
        let (alertViewSpy, sut) = makeSut()
        let signupViewModel = SignupViewModel(email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo nome e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_email_is_not_provided() {
        let (alertViewSpy, sut) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo email e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_is_not_provided() {
        let (alertViewSpy, sut) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo password e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_confirmation_is_not_provided() {
        let (alertViewSpy, sut) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo confirmar senha e obrigatorio"))
    }
    
    func test_signup_should_show_error_if_password_and_password_confirmation_are_differents() {
        let (alertViewSpy, sut) = makeSut()
        let signupViewModel = SignupViewModel(name: "willian", email: "any@gmail.com", password: "123", passwordConfirmation: "456")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "As senhas devem coincidir"))
    }
}

extension SignupPresenterTests {
    
    func makeSut() -> (AlertViewSpy, SignupPresenter) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignupPresenter(alertView: alertViewSpy)
        return (alertViewSpy, sut)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewmodel: AlertViewModel) {
            self.viewModel = viewmodel
        }
    }
}
