//
//  DataTests.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import XCTest
@testable import Data

protocol HttpPostClient {
    func post( url: URL)
}

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        self.httpClient.post(url: url)
    }
}

final class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "https://www.google.com.br")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        
        sut.add()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

class HttpClientSpy {
    var url: URL?
}

extension HttpClientSpy: HttpPostClient {
    func post(url: URL) {
        self.url = url
    }
}
