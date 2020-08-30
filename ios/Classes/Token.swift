//
//  Token.swift
//  ConektaCardToken-Swift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Conekta. All rights reserved.
//
import Foundation

class Token
{
    var baseURI = ""
    var publicKey = ""
    var resourceURI = ""

    var card: Card?
    var deviceFingerprint = ""

    init()
    {
        self.resourceURI = "/tokens"
    }

    convenience init(card: Card)
    {
        self.init()
        self.card = card
    }

    func create(completionHandler: @escaping (_ response: Any) -> (), errorHandler: @escaping (_ error: NSError) -> ())
    {
        if let url = NSURL(string: "\(self.baseURI)\(self.resourceURI)")
        {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"

            if let apiKey = self.apiKeyBase64(apiKey: self.publicKey)
            {
                request.setValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
            }

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
            request.setValue("{\"agent\":\"Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
            request.httpBody = self.card?.jsonSerialization() as Data?
            
            let connection = Connection(request: request as URLRequest)
            connection.request(completionHandler: completionHandler, errorHandler: errorHandler)
        }
    }

    func apiKeyBase64(apiKey: String) -> String?
    {
        let plainData = apiKey.data(using: String.Encoding.utf8)

        if let apiKeyBase64Data = plainData?.base64EncodedData(options: .endLineWithLineFeed)
        {
            return NSString(data: apiKeyBase64Data, encoding: String.Encoding.utf8.rawValue) as String?
        }

        return nil
    }
}
