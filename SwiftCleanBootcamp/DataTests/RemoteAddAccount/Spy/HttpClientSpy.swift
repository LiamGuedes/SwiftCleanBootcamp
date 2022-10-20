//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

class HttpClientSpy {
    var url: URL?
    var data: Data?
}

extension HttpClientSpy: HttpPostClient {
    func post(to url: URL, with data: Data?) {
        self.url = url
        self.data = data
    }
}
