//
//  TranslateServiceTestCase.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 13/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import XCTest
@testable import Le_baluchon

class TranslateServiceTestCase: XCTestCase {
    var text = "test"
    var code = "en"
    
    // MARK: - Detection Language Test
    
    func testGetDetectionShouldPostFailedCallbackError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(text: text) { (translate) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostFailedCallbackIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(text: text) { (translate) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostFailedCallbackIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(text: text) { (translate) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getDetectionLang(text: text) { result in
            switch result {
            case .success(let results):
                guard let data = results.data.detections.first else { return }
                guard let language = data.first?.language else { return }
                XCTAssertTrue(language == "fr")
                expectation.fulfill()
            case .failure(let error):
                print(error)
                
            }
            
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Supported Language Test
    
    func testGetSupportedLanguageShouldPostFailedCallbackError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getLanguageList() { (translate) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSupportedLanguageShouldPostFailedCallbackIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getLanguageList() { (translate) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSupportedLanguageShouldPostFailedCallbackIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getLanguageList() { (translate) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetvShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getLanguageList() { (translate) in
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Supported Language Test
    
    func testgetTranslationShouldPostFailedCallbackError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getTranslation(text:text, code: code) { (translate) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetTranslationShouldPostFailedCallbackIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getTranslation(text:text, code: code) { (translate) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetTranslationShouldPostFailedCallbackIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getTranslation(text:text, code: code) { (translate) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testgetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getTranslation(text:text, code: code) { (translate) in
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
