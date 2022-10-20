//
//  DataTests.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import XCTest
@testable import Data

protocol HttpClient {
    func post( url: URL)
}

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpClient
    
    init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        self.httpClient.post(url: url)
    }
}

final class RemoteAddAccountTests: XCTestCase {
    func test_() {
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

extension HttpClientSpy: HttpClient {
    func post(url: URL) {
        self.url = url
    }
}
