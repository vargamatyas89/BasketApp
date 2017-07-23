//
//  Basket.swift
//  BasketApp
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

class BasketElement: Hashable {
    var name: String
    var price: Double
    var currency = "USD"
    var type: BasketElementType = .none
    fileprivate var _hashValue: Int
    
    public var hashValue: Int {
        get {
            return _hashValue
        }
    }
    
    init(type: BasketElementType, price: Double) {
        self.price = price
        self.type = type
        
        switch self.type{
        case .eggs:
            self.name = "Eggs"
            self._hashValue = 0
            break
        case .peas:
            self.name = "Peas"
            self._hashValue = 1
            break
        case .milk:
            self.name = "Milk"
            self._hashValue = 2
            break
        case .beans:
            self.name = "Beans"
            self._hashValue = 3
            break
        default:
            self.name = ""
            self._hashValue = 5
            break
        }
    }
    
    // Later if we want to add any additional type (beyond the 4) to the basket
    init(name: String, price: Double) {
        self.name = name
        self.price = price
        self.type = .other
        self._hashValue = 4
    }

}

extension BasketElement: Equatable {
    public static func ==(lhs: BasketElement, rhs: BasketElement) -> Bool {
        return lhs.price == rhs.price && lhs.type == rhs.type && lhs.name == rhs.name && lhs._hashValue == rhs._hashValue
    }
}
