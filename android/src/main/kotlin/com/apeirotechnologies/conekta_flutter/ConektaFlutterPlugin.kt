package com.apeirotechnologies.conekta_flutter

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

private const val API_KEY_ARGUMENT_NAME = "apiKey"
private const val CARD_NAME_ARGUMENT_NAME = "cardName"
private const val CARD_NUMBER_ARGUMENT_NAME = "cardNumber"
private const val CVV_ARGUMENT_NAME = "cvv"
private const val EXPIRATION_MONTH_ARGUMENT_NAME = "expirationMonth"
private const val EXPIRATION_YEAR_ARGUMENT_NAME = "expirationYear"
private const val SET_API_KEY_METHOD_NAME = "setApiKey"
private const val ON_CREATE_CARD_TOKEN_METHOD_NAME = "onCreateCardToken"
private const val METHOD_CHANNEL_NAME = "conekta_flutter"

/** ConektaFlutterPlugin */
class ConektaFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var conektaProvider: ConektaProvider

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        conektaProvider = ConektaProvider()
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
            channel.setMethodCallHandler(ConektaFlutterPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) =
        when (call.method) {
            SET_API_KEY_METHOD_NAME -> {
                call.argument<String>(API_KEY_ARGUMENT_NAME)?.let {
                    conektaProvider.setApiKey(it)
                    result.success(true)
                } ?: result.error(
                    ConektaError.ApiKeyNotProvided.code,
                    ConektaError.ApiKeyNotProvided.message,
                    null
                )
            }
            ON_CREATE_CARD_TOKEN_METHOD_NAME -> getCardArgument(call.arguments)?.let { card ->
                conektaProvider.getApiKey()?.let {
                    conektaProvider.onCreateCardToken(card) { token, error ->
                        if (error == null) {
                            result.success(token)
                        } else {
                            result.error(
                                error.code,
                                error.message,
                                null
                            )
                        }
                    }
                } ?: result.error(
                    ConektaError.ApiKeyNotProvided.code,
                    ConektaError.ApiKeyNotProvided.message,
                    null
                )
            } ?: result.error(
                ConektaError.InvalidCardArguments.code,
                ConektaError.InvalidCardArguments.message,
                null
            )
            else -> result.notImplemented()
        }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) =
        channel.setMethodCallHandler(null)

    override fun onDetachedFromActivity() = Unit

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

    override fun onAttachedToActivity(binding: ActivityPluginBinding) =
        conektaProvider.init(binding.activity)

    override fun onDetachedFromActivityForConfigChanges() {
    }

    private fun getCardArgument(arguments: Any?) = if (arguments != null
        && arguments as? Map<*, *> != null
        && arguments[CARD_NAME_ARGUMENT_NAME] as? String != null
        && arguments[CARD_NUMBER_ARGUMENT_NAME] as? String != null
        && arguments[CVV_ARGUMENT_NAME] as? String != null
        && arguments[EXPIRATION_MONTH_ARGUMENT_NAME] as? String != null
        && arguments[EXPIRATION_YEAR_ARGUMENT_NAME] as? String != null
    ) {
        ConektaCard(
            cardName = arguments[CARD_NAME_ARGUMENT_NAME] as String,
            cardNumber = arguments[CARD_NUMBER_ARGUMENT_NAME] as String,
            cvv = arguments[CVV_ARGUMENT_NAME] as String,
            expirationMonth = arguments[EXPIRATION_MONTH_ARGUMENT_NAME] as String,
            expirationYear = arguments[EXPIRATION_YEAR_ARGUMENT_NAME] as String
        )
    } else {
        null
    }
}
