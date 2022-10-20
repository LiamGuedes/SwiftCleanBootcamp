//
//  DataTests.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import XCTest
import Domain

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        let data = try? JSONEncoder().encode(addAccountModel)
        self.httpClient.post(to: url, with: data)
    }
}

final class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://www.google.com.br")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(name: "any", email: "any@mail.com", password: "123", passwordConfirmation: "123")
        
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let url = URL(string: "https://www.google.com.br")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(name: "any", email: "any@mail.com", password: "123", passwordConfirmation: "123")
        let data = try? JSONEncoder().encode(addAccountModel)
        
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }
}
