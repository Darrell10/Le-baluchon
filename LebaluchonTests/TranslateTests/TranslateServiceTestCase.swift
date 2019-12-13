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
    var urlParams = ["key": "", "q": ""]
    
    // MARK: - Detection Language Test
    
    func testGetDetectionShouldPostFailedCallbackError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (translate) in
            XCTAssertNotNil(NetWorkError.noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostFailedCallbackIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (translate) in
            XCTAssertNotNil(NetWorkError.badUrl)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostFailedCallbackIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        translateService.getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (translate) in
            XCTAssertNotNil(NetWorkError.jsonError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "wait for queue change")

        translateService.getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (translate) in
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
}
