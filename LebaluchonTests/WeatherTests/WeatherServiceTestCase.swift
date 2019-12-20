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
    
    var urlParams = [String: String]()
    
        // MARK: - getWeather function test
    
    func testgetWeatherShouldPostFailedCallbackError() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(usingTranslationAPI: .weather, urlParams: urlParams) { (weather) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostFailedCallbackIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(usingTranslationAPI: .weather, urlParams: urlParams) { (weather) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostFailedCallbackIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(usingTranslationAPI: .weather, urlParams: urlParams) { (weather) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(usingTranslationAPI: .weather, urlParams: urlParams) { (devise) in
            XCTAssertNotNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
