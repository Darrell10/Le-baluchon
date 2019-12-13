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
    let lat = 47.3216
    let long = 5.0415
    
        // MARK: - GetNYWeather function test
    
    func testGetNYWeatherShouldPostFailedCallbackError() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNYWeatherShouldPostFailedCallbackIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNYWeatherShouldPostFailedCallbackIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (weather) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetNYWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getNYWeather { (devise) in
            XCTAssertNotNil(devise)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - GetUserWeather function test
    
    func testGetUserWeatherShouldPostFailedCallbackError() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getUserWeather(lat, long) { (weather) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetUserWeatherShouldPostIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getUserWeather(lat, long) { (weather) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetUserWeatherShouldPostIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getUserWeather(lat, long) { (weather) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetUserWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getUserWeather(lat, long, completion: { (weather) in
            XCTAssertNotNil(weather)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

}
