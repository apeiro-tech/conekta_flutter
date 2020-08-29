package com.apeirotechnologies.conekta_flutter

import android.app.Activity
import io.conekta.conektasdk.Card
import io.conekta.conektasdk.Conekta
import io.conekta.conektasdk.Token
import org.json.JSONObject
import java.lang.ref.WeakReference

private const val UNEXPECTED_CARD_TOKEN_ERROR =
    "An unexpected error occurred in the card token process"
private const val UNEXPECTED_CARD_TOKEN_CODE = "unexpected_error"

class ConektaProvider : ConektaInterface {

    private lateinit var activity: WeakReference<Activity>

    override fun init(activity: Activity) {
        this.activity = WeakReference(activity)
        Conekta.collectDevice(activity)
    }

    override fun setApiKey(apiKey: String) = Conekta.setPublicKey(apiKey)

    override fun getApiKey(): String? =
        if (Conekta.getPublicKey().isNullOrEmpty()) null else Conekta.getPublicKey()

    override fun onCreateCardToken(
        conektaCard: ConektaCard,
        callback: ConektaCardTokenCallback
    ) {
        activity.get()?.let {
            Token(it).apply {
                onCreateTokenListener { json -> handleResponse(json, callback) }
                create(
                    Card(
                        conektaCard.cardName,
                        conektaCard.cardNumber,
                        conektaCard.ccv,
                        conektaCard.expirationMonth,
                        conektaCard.expirationYear
                    )
                )
            }
        } ?: callback(null, ConektaError.ActivityNotInstantiated)
    }

    private fun handleResponse(json: JSONObject, callback: ConektaCardTokenCallback) = try {
        if (json.getString("object") == "error") {
            callback(
                null,
                ConektaError.CardTokenError(json.getString("code"), json.getString("message"))
            )
        } else {
            callback(json.getString("id"), null)
        }
    } catch (err: Exception) {
        callback(
            null,
            ConektaError.CardTokenError(
                UNEXPECTED_CARD_TOKEN_CODE,
                err.message ?: UNEXPECTED_CARD_TOKEN_ERROR
            )
        )
    }
}