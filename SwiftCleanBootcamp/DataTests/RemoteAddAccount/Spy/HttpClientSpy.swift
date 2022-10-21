//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation
@testable import Data

class HttpClientSpy {
    var url = [URL]()
    var data: Data?
    var callsCount = 0
}

extension HttpClientSpy: HttpPostClient {
    func post(to url: URL, with data: Data?) {
        self.url.append(url)
        self.data = data
    }
}
