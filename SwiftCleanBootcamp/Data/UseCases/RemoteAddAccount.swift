//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Willian Guedes on 20/10/22.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completition completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.httpClient.post(to: url, with: addAccountModel.toData()) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
                case .success(let data):
                    if let model: AccountModel = data?.toModel() {
                        completion(.success(model))
                    } else {
                        completion(.failure(.invalidData))
                    }
                case .failure(_): completion(.failure(.unexpected))
            }
        }
    }
}
