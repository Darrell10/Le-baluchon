//
//  WeatherServiceTestCase.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 26/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import XCTest
@testable import Le_baluchon

class WeatherServiceTestCase: XCTestCase {
    func testGetDeviseShouldPostFailedCallbackError() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetQuoteShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (devise) in
            
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
