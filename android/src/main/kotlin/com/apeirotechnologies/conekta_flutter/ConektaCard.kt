package com.apeirotechnologies.conekta_flutter

data class ConektaCard(
    val cardName: String,
    val cardNumber: String,
    val expirationMonth: String,
    val expirationYear: String,
    val cvv: String
)