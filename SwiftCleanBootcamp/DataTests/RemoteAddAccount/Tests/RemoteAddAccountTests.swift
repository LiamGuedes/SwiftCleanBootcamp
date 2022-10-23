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
        let url = makeURL()
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
        let expectedAccount = makeAccountModel()

        self.expect(sut, completeWith: .success(expectedAccount), when: {
            httpClientSpy.completeWithData(expectedAccount.toData()!)
        })
    }
    
    func test_add_should_call_httpClient_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy)  = self.makeSut()
        
        expect(sut, completeWith: .failure(.invalidData), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeURL(), httpClient: httpClientSpy)
        var result: Result<AccountModel, DomainError>?
        
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTests {
    
    // TIP: Factory Pattern
    /// Factory Pattern Example:  The Factory Method separates product construction code from the code that actually uses the product. Therefore it’s easier to extend the product construction code independently from the rest of the code.
    func makeSut(url: URL = URL(string: "https://www.google.com.br")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        
        self.checkMemoryLeak(for: sut, file: file, line: line)
        self.checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        
        return (sut, httpClientSpy)
    }
    
    // TIP: Return the test Fails Answer
    /// Use "file: StaticString = #filePath, line: UInt = #line", when you have helpers that ensures XCTAssert. It will provides the answer in line o helper caller.
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
}
