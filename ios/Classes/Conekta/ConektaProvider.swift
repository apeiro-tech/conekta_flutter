//
//  ConektaProvider.swift
//  conekta_flutter
//
//  Created by Alfonso Osorio Avilez on 30/08/20.
//

class ConektaProvider: ConektaProtocol {
    private var conekta: Conekta? = nil
    
    func start(view: UIViewController) {
        conekta = Conekta()
        conekta?.viewController = view
        conekta?.collectDevice()
    }
    
    func setApiKey(apiKey: String) {
        conekta?.publicKey = apiKey
    }
    
    func getApiKey() -> String {
        return conekta?.publicKey ?? ""
    }
    
    func onCreateCardToken(conektaCard: ConektaCard, callback: @escaping ConektaCardTokenCallback) {
        let card = Card(number: conektaCard.cardNumber, name: conektaCard.cardName, cvc: conektaCard.cvv, expMonth: conektaCard.expirationMonth, expYear: conektaCard.expirationYear)
        let token = conekta?.token(card: card)
        token?.create(completionHandler: { (response) in
            if let json = response as? Dictionary<String, Any> {
                if json["object"] as? String == "error",
                    let code = json["code"] as? String,
                    let message = json["message"] as? String {
                    callback(nil, CardTokenError(code: code, message: message))
                } else {
                    callback(json["id"] as? String, nil)
                }
            }
        }, errorHandler: { (error) in
            callback(nil, CardTokenError(code: error.localizedDescription, message: error.description))
        })
    }
}
