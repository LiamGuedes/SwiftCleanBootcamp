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
    var completion: ((HttpError) -> Void)?
}

extension HttpClientSpy: HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void) {
        self.url.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(error)
    }
}
