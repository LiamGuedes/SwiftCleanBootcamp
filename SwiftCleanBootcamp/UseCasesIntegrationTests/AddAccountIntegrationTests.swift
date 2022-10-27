//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Willian Guedes on 26/10/22.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {
    func test_add_account() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Willian Guedes", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
        let exp = expectation(description: "warning")
        
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expected success got \(result) instead")
            case .success(let account):
                print(account)
                XCTAssertNotNil(account.accessToken)
                XCTAssertEqual(account.name, addAccountModel.name)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 100)
    }
}
