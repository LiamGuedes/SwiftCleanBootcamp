//
//  HttpPostClient.swift
//  Data
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation
import Domain

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}
