//
//  BasketProperties.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 24..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

protocol BasketProperties {
    var currencyList: [String]! { get set }
    var basket: [BasketElement]! { get set }
}
