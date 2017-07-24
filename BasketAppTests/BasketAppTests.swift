//
//  BasketAppTests.swift
//  BasketAppTests
//
//  Created by Varga, Matyas on 2017. 07. 23..
//  Copyright © 2017. MyOrganization. All rights reserved.
//

import XCTest
@testable import BasketApp

class BasketAppTests: XCTestCase {
    
    private let mockJSONPositiveResult = true
    private let mockJSONNegativeResult = false
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadCurrencies() {
        let currencyConnectionHandler = CurrencyConnectionHandler()
        let expectation = self.expectation(description: "Download successful")
        
        currencyConnectionHandler.loadCurrencyList { json in
            XCTAssertNil(json, "Failed, there is no json file downloaded.")
            expectation.fulfill()
//            if let json = json {
//                XCTAssertTrue(json["success"] as! Bool == self.mockJSONPositiveResult, "The request returned with unsuccess.")
//                XCTAssertFalse(json["success"] as! Bool == self.mockJSONNegativeResult, "The request returned with unsuccess.")
//            }
        }
        
        self.waitForExpectations(timeout: 10)
    }
    
}
