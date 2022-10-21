//
//  DataTests.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import XCTest
import Domain
@testable import Data

final class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://www.google.com.br")!
        let (sut, httpClientSpy)  = self.makeSut(url: url)
        let addAccountModel = self.makeAddAccountModel()
        
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy)  = self.makeSut()
        
        sut.add(addAccountModel: self.makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.data, self.makeAddAccountModel().toData())
    }
}

extension RemoteAddAccountTests {
    
    // MARK: Factory Pattern
    /// Factory Pattern Example:  The Factory Method separates product construction code from the code that actually uses the product. Therefore it’s easier to extend the product construction code independently from the rest of the code.
    func makeSut(url: URL = URL(string: "https://www.google.com.br")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any", email: "any@mail.com", password: "123", passwordConfirmation: "123")
    }
}
