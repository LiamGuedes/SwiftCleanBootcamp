//
//  AlamofireAdapterTest.swift
//  InfraTests
//
//  Created by Willian Guedes on 26/10/22.
//

import Foundation

class URLProtocolStub: URLProtocol {
    /// Para adicionar um observable corretamente, primeiramente iremos adicionar uma variavel estatica que ira recever uma funcao do tipo que voce definir,
    /// no nosso caso, para fazer os testes do Alamofire, utilizaremos URLRequest. Detalhe, voce pode chamar de qualquer nome, entretanto o Design Pattern
    /// Observable, nos recomenda colocar o nome como "emit"
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    /// Com a variavel criada corretamente, nos devemos implementar uma funcao que retorne um handler, que sera chamado na parte do codigo que voce quiser.
    /// Alem disso voce devera passar o completion recebido para o emit, para que assim voce consiga executar a funcao sempre que ouver uma determinado
    /// requisicao a ela.
    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        URLProtocolStub.data = data
        URLProtocolStub.response = response
        URLProtocolStub.error = error
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
        
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        // Sempre que fizermos testes de interceptacao, devemos completar o request atraves da funcao abaixo:
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
