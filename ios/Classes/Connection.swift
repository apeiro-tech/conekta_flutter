//
//  Connection.swift
//  ConektaCardToken-Swift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Conekta. All rights reserved.
//
import Foundation

class Connection
{
    var url: NSURL?
    var request: URLRequest?
    var apiKey = ""
        
    convenience init(request: URLRequest)
    {
        self.init()
        self.request = request
    }
    
    func request(completionHandler: @escaping (_ response: Any) -> (), errorHandler: @escaping (_ error: NSError) -> ()) {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        if let request = request {
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    errorHandler(error as NSError)
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        completionHandler(json)
                    } catch{
                        print("Couldn't serialize json response")
                    }
                }
            })
            task.resume()
        }
    }
}
