//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

class HttpClientSpy {
    var url: URL?
}

extension HttpClientSpy: HttpPostClient {
    func post(url: URL) {
        self.url = url
    }
}
