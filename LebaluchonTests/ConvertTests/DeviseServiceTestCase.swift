//
//  ConvertTestCase.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 23/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import XCTest
@testable import Le_baluchon

class DeviseServiceTestCase: XCTestCase {
    var currency = "USD"
    
    func testGetDeviseShouldPostFailedCallbackError() {
        let devisesService = CurrencyService(
            convertSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorConvert))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency(currency: currency) { (devise) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectResponse() {
        let devisesService = CurrencyService(
            convertSession: URLSessionFake(data: FakeResponseData.ConvertCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency(currency: currency) { (devise) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectData() {
        let devisesService = CurrencyService(
            convertSession: URLSessionFake(data: FakeResponseData.ConvertIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency(currency: currency) { (devise) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let devisesService = CurrencyService(
            convertSession: URLSessionFake(data: FakeResponseData.ConvertCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency(currency: currency) { result in
         guard case .success(let decodedData) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertTrue(decodedData.rates["USD"] == 1.10213)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
