//
//  CurrencyLayerConnectionHandler.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 24..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import Foundation

class CurrencyConnectionHandler {

    let urlSession: URLSession
    let config: URLSessionConfiguration
    var currencyList: [String: Any]!
    var exchangeRate: Double = 0.0
    
    init() {
        self.config = .default
        self.urlSession = URLSession(configuration: self.config)
    }
    
    func loadCurrencyList() {
        let dataTask = self.urlSession.dataTask(with: Defaults.loadCurrencyListURL) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Some error happened.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let responseData = data , let json = self.loadJSONToDictionary(from: responseData), let success = json["success"] as? Bool, success else {
                // Error handling if something fails in the guard statement
                if let data = data, let json = self.loadJSONToDictionary(from: data) {
                    self.exchangeErrorhandler(json)
                } else {
                    print("Some strange error happened.")
                }
                return
            }
            
            self.currencyList = json["currencies"] as! [String : Any]
        }
        
        dataTask.resume()
    }
    
    func loadJSONToDictionary(from data: Data) -> [String : Any]? {
        var result: [String: Any]?
        do {
            result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadExchangeRate(from sourceCurrency: String, to destinationCurrency: String) {
        let dataTask = self.urlSession.dataTask(with: Defaults.loadLiveCurrenciesURL) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Some error happened during the request.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let responseData = data , let json = self.loadJSONToDictionary(from: responseData), let success = json["success"] as? Bool, success else {
                // Error handling if something fails in the guard statement
                if let data = data, let json = self.loadJSONToDictionary(from: data) {
                    self.exchangeErrorhandler(json)
                } else {
                    print("Some strange error happened.")
                }
                return
            }
            
            let exchangeRateSearchString = sourceCurrency + destinationCurrency
            guard let currencies = json["currencies"] as? [String: Double], let rate = currencies[exchangeRateSearchString] else {
                print("Unfortunately exchange rate not found.")
                return
            }
            
            self.exchangeRate = rate
        }
        
        dataTask.resume()
    }
    
    func exchangeErrorhandler(_ json: [String: Any]) {
        if let error = json["error"] as? [String: Any] {
            print("Error happened. \(error["code"] ?? "") " + " - " + " \(error["info"] ?? "")")
        }
    }
}

