//
//  ConvertFakeResponseData.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 23/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // Convert
    class ConvertError: Error {}
    static let errorConvert = ConvertError()
    static var ConvertCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Convert", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // Weather
    class WeatherError: Error {}
    static let errorWeather = WeatherError()
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // Translate
    class TranslateError: Error {}
    static let errorTranslate = TranslateError()
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslateDetection", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    
    static let ConvertIncorrectData = "erreur".data(using: .utf8)!
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    static let translateIncorrectData = "erreur".data(using: .utf8)!
}
