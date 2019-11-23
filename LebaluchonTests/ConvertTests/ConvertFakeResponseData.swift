//
//  ConvertFakeResponseData.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 23/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class ConvertFakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ConvertError: Error {}
    
    static let error = ConvertError()
    
    static var ConvertCorrectData: Data {
        let bundle = Bundle(for: ConvertFakeResponseData.self)
        let url = bundle.url(forResource: "Convert", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let ConvertIncorrectData = "erreur".data(using: .utf8)!
}
