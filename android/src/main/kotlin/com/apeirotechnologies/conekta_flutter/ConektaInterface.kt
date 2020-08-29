package com.apeirotechnologies.conekta_flutter

import android.app.Activity

typealias ConektaCardTokenCallback = (String?, ConektaError?) -> Unit

interface ConektaInterface {
    fun init(activity: Activity)

    fun setApiKey(apiKey: String)

    fun getApiKey(): String?

    fun onCreateCardToken(conektaCard: ConektaCard, callback: ConektaCardTokenCallback)
}