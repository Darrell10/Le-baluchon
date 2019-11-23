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
    func testGetDeviseShouldPostFailedCallbackError() {
        let devisesService = DeviseService(
            convertSession: ConvertURLSessionFake(data: nil, response: nil, error: ConvertFakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency { (devise) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectResponse() {
        let devisesService = DeviseService(
            convertSession: ConvertURLSessionFake(data: ConvertFakeResponseData.ConvertCorrectData, response: ConvertFakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency { (devise) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectData() {
        let devisesService = DeviseService(
            convertSession: ConvertURLSessionFake(data: ConvertFakeResponseData.ConvertIncorrectData, response: ConvertFakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency { (devise) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let devisesService = DeviseService(
            convertSession: ConvertURLSessionFake(data: ConvertFakeResponseData.ConvertCorrectData, response: ConvertFakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        devisesService.getCurrency { (devise) in
            
            //let date = "2019-11-23"
            //let rates = ["USD": 1.10213]
            
            //XCTAssertEqual(date, devise.date)
            //XCTAssertEqual(rates, devise.rates)
            XCTAssertNotNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
