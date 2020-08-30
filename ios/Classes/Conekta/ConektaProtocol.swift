//
//  ConektaProtocol.swift
//  conekta_flutter
//
//  Created by Alfonso Osorio Avilez on 30/08/20.
//

typealias ConektaCardTokenCallback = (String?, CardTokenError?) -> Void

protocol ConektaProtocol {
    func start(view: UIViewController)
    
    func setApiKey(apiKey: String)
    
    func getApiKey() -> String
    
    func onCreateCardToken(conektaCard: ConektaCard, callback: @escaping ConektaCardTokenCallback)
}
