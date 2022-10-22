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
    var completion: ((Result<Data, HttpError>) -> Void)?
}

extension HttpClientSpy: HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        self.url.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
