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
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_test() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)

        let url = makeURL()
        
        sut.post(to: url)
        
        let exp = expectation(description: "waiting")
        URLProtocolStub.requestObserver { request in
            XCTAssertEqual(url, request.url)
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


