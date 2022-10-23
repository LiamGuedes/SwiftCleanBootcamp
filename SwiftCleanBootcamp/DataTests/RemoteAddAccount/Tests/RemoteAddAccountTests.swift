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
        let url = self.makeURL()
        let (sut, httpClientSpy)  = self.makeSut(url: url)
        let addAccountModel = self.makeAddAccountModel()
        
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.url, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy)  = self.makeSut()
        
        sut.add(addAccountModel: self.makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.data, self.makeAddAccountModel().toData())
    }
    
    func test_add_should_call_httpClient_with_error_if_client_fails() {
        let (sut, httpClientSpy)  = self.makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_add_should_call_httpClient_with_data_if_client_complete_with_data() {
        let (sut, httpClientSpy)  = self.makeSut()
        let expectedAccount = self.makeAccountModel()

        self.expect(sut, completeWith: .success(expectedAccount), when: {
            httpClientSpy.completeWithData(expectedAccount.toData()!)
        })
    }
    
    func test_add_should_call_httpClient_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy)  = self.makeSut()
        
        expect(sut, completeWith: .failure(.invalidData), when: {
            httpClientSpy.completeWithData(self.makeInvalidData())
        })
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
    
    func expect(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action:() -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: self.makeAddAccountModel()) { receivedResult in
            switch (receivedResult, expectedResult) {
                case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(receivedData, expectedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult), but receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any", email: "any@mail.com", password: "123", passwordConfirmation: "123")
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "id_123" , name: "any", email: "any@mail.com", password: "123")
    }
    
    func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
    }
    
    func makeURL() -> URL {
        return URL(string: "https://www.google.com.br")!
    }
}
