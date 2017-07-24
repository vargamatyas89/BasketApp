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
    private var currencyConnectionHandler: CurrencyConnectionHandler!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setConnectionHandler()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func setConnectionHandler() {
        self.currencyConnectionHandler = CurrencyConnectionHandler()
    }
    
    func testDownloadCurrenciesSuccessfull() {
        let expectation = self.expectation(description: "Download successful")
        
        self.currencyConnectionHandler.loadCurrencyList { json in
            XCTAssertNotNil(json, "Failed, there is no json file downloaded.")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10)
    }
    
    func testDownloadExchangeRateSuccessful() {
        let expectation = self.expectation(description: "Exchange rate download is successful")
        
        self.currencyConnectionHandler.loadExchangeRate(to: "EUR") { rate in
            XCTAssertNotEqual(rate, 0, "Failed, the exchange rate is zero.")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10)
    }
    
    func testDownloadExchangeRateUnsuccessful() {
        let expectation = self.expectation(description: "Exchange rate download is not successful")
        
        self.currencyConnectionHandler.loadExchangeRate(from: "CHF", to: "EUR") { rate in
            XCTAssertNil(rate, "Failed, no exchange rate found.")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10)
    }
    
    
    
}
