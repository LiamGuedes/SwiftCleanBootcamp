//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation
import Domain

public final class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        self.httpClient.post(to: url, with: addAccountModel.toData())
    }
}
