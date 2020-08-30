//
//  ConektaError.swift
//  conekta_flutter
//
//  Created by Alfonso Osorio Avilez on 30/08/20.
//

struct ApiKeyNotProvided {
    static var code: String = "api_key_not_provided"
    static var message: String = "Conekta API Key not provided"
}

struct InvalidCardArguments {
    static var code: String = "invalid_card_arguments"
    static var message: String = "One of the card attributes is invalid"
}

struct CardTokenError {
    var code: String
    var message: String
}

struct ActivityNotInstantiated {
    static let code: String = "activity_not_instantiate"
    static let message: String = "Could not get the instance of the main activity"
}
