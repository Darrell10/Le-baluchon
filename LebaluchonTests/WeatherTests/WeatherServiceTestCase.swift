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
    var lat = "47.3216"
    var lon = "5.0415"
    
    // MARK: - getWeather function test
    
    func testgetWeatherShouldPostFailedCallbackError() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(lat: lat, lon: lon) { (weather) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostFailedCallbackIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(lat: lat, lon: lon) { (weather) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostFailedCallbackIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(lat: lat, lon: lon) { (weather) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeather(lat: lat, lon: lon) { result in
            guard case .success(let decodedData) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            guard let first = decodedData.list.first else { return }
            XCTAssertTrue(first.name == "Dijon")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
