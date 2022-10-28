
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
    func testExample() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = SignupPresenter(alertView: alertViewSpy)
        let signupViewModel = SignupViewModel(email: "any@gmail.com", password: "123", passwordConfirmation: "123")
        
        sut.signup(viewmodel: signupViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na Validacao", message: "O campo nome e obrigatorio"))
    }
}

extension SignupPresenterTests {
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewmodel: AlertViewModel) {
            self.viewModel = viewmodel
        }
    }
}
