
//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Willian Guedes on 28/10/22.
//

import XCTest

class SignupPresenter {
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signup(viewmodel: SignupViewModel) {
        if viewmodel.name == nil || viewmodel.name!.isEmpty {
            alertView.showMessage(viewmodel: AlertViewModel(title: "Falha na Validacao", message: "O campo nome e obrigatorio"))
        } else if viewmodel.email == nil || viewmodel.email!.isEmpty {
            alertView.showMessage(viewmodel: AlertViewModel(title: "Falha na Validacao", message: "O campo email e obrigatorio"))
        } else if viewmodel.password == nil || viewmodel.password!.isEmpty {
            alertView.showMessage(viewmodel: AlertViewModel(title: "Falha na Validacao", message: "O campo password e obrigatorio"))
        }
    }
}

protocol AlertView {
    func showMessage(viewmodel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignupViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

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
