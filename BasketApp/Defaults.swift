//
//  Defaults.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import Foundation

struct Defaults {
    
    private static let baseURL = URL(string: "http://apilayer.net/api/")!
    private static let live = "live?"
    private static let list = "list?"
    private static let accessKey = "access_key=22f2dc4edeaef4adea4f3cda9ff1d6b7"
    public static let loadCurrencyListURL = baseURL.appendingPathComponent(list).appendingPathComponent(accessKey)
    public static let loadLiveCurrenciesURL = baseURL.appendingPathComponent(live).appendingPathComponent(accessKey)
    
}

