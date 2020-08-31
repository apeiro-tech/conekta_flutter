package com.apeirotechnologies.conekta_flutter

sealed class ConektaError(val code: String, val message: String) {
    object ApiKeyNotProvided : ConektaError("api_key_not_provided", "Conekta API Key not provided")
    object InvalidCardArguments : ConektaError("invalid_card_arguments", "One of the card attributes is invalid")
    class CardTokenError(code: String, message: String) : ConektaError(code, message)
}