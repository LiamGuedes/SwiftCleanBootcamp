//
//  HttpPostClient.swift
//  Data
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
