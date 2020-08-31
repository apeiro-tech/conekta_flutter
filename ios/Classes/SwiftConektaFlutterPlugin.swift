import Flutter
import UIKit

private let setApiKeyMethodName = "setApiKey"
private let onCreateCardTokenMethodName = "onCreateCardToken"

public class SwiftConektaFlutterPlugin: NSObject, FlutterPlugin {
    private var conektaProvider: ConektaProvider? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "conekta_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftConektaFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public override init() {
        conektaProvider = ConektaProvider()
        let viewController = UIApplication.shared.delegate!.window!!.rootViewController as! FlutterViewController
        conektaProvider?.start(view: viewController)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let mapArguments = call.arguments as! Dictionary<String, Any>
        if call.method == setApiKeyMethodName {
            if let apiKey = mapArguments["apiKey"] as? String {
                conektaProvider?.setApiKey(apiKey: apiKey)
                result(true)
            } else {
                result(FlutterError(code: ApiKeyNotProvided.code,
                                    message: ApiKeyNotProvided.message,
                                    details: nil))
            }
        } else if call.method == onCreateCardTokenMethodName {
            if let card = getCardArguments(arguments: mapArguments) {
                conektaProvider?.onCreateCardToken(conektaCard: card, callback: { (token, error) in
                    if error == nil {
                        result(token)
                    } else {
                        result(FlutterError(code: error!.code, message: error!.message, details: nil))
                    }
                })
            } else {
                result(FlutterError(code: InvalidCardArguments.code,
                message: InvalidCardArguments.message,
                details: nil))
            }
        }
    }
    
    private func getCardArguments(arguments: Dictionary<String, Any>) -> ConektaCard? {
        if let cardName = arguments["cardName"] as? String,
            let cardNumber = arguments["cardNumber"] as? String,
            let cvv = arguments["cvv"] as? String,
            let expirationMonth = arguments["expirationMonth"] as? String,
            let expirationYear = arguments["expirationYear"] as? String {
            return ConektaCard(cardName: cardName, cardNumber: cardNumber, expirationMonth: expirationMonth, expirationYear: expirationYear, cvv: cvv)
        } else {
            return nil
        }
    }
}
