//
//  AlamofireAdapter.swift
//  InfraTests
//
//  Created by Willian Guedes on 23/10/22.
//
// Adapter: Um design pattern que adapta duas interfaces diferentes.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data?) {
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        
        self.testRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data() {
        self.testRequestFor(data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
}

extension AlamofireAdapterTests {
    func makeSut () -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
    }
    
    func testRequestFor(url: URL = makeURL(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = self.makeSut()
        let url = url
        
        sut.post(to: url, with: data)
        
        let exp = expectation(description: "waiting")
        URLProtocolStub.requestObserver { request in
            action(request)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}


class URLProtocolStub: URLProtocol {
    /// Para adicionar um observable corretamente, primeiramente iremos adicionar uma variavel estatica que ira recever uma funcao do tipo que voce definir,
    /// no nosso caso, para fazer os testes do Alamofire, utilizaremos URLRequest. Detalhe, voce pode chamar de qualquer nome, entretanto o Design Pattern
    /// Observable, nos recomenda colocar o nome como "emit"
    static var emit: ((URLRequest) -> Void)?
    
    /// Com a variavel criada corretamente, nos devemos implementar uma funcao que retorne um handler, que sera chamado na parte do codigo que voce quiser.
    /// Alem disso voce devera passar o completion recebido para o emit, para que assim voce consiga executar a funcao sempre que ouver uma determinado
    /// requisicao a ela.
    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    // canInit: ira fazer com que todas as nossas URL dentro daquela session sejam interceptadas, nao importa para onde aquela URL leve.
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // startLoading(): Aqui nos iremos fazer os testes, para o caso de o Alamofire responder postivamente ou negativamente.
    override func startLoading() {
        URLProtocolStub.emit?(request)
    }
    
    override func stopLoading() { }
}


