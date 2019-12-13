//
//  Translate.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

// MARK: - Translation struct
struct TranslationLanguage {
    let code: String
    let name: String
}

struct GoogleTranslate: Decodable {
    let data: DataLanguage
}

struct DataLanguage: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}

// MARK: - Detection struct

struct GoogleDetection: Decodable {
    let data: Data
}
struct Data: Decodable {
    let detections: [[Detection]]
}

struct Detection: Codable {
    let language: String
}

// MARK: - Language struct

struct GoogleLanguage: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let languages: [Language]
}

struct Language: Codable {
    let language: String
    let name: String
}

// MARK: - Enum Translation API

enum TranslationAPI {
    case detectLanguage
    case translate
    case supportedLanguages
    
    func getURL() -> String {
        var urlString = ""
        
        switch self {
        case .detectLanguage:
            urlString = "https://translation.googleapis.com/language/translate/v2/detect"
        case .translate:
            urlString = "https://translation.googleapis.com/language/translate/v2"
        case .supportedLanguages:
            urlString = "https://translation.googleapis.com/language/translate/v2/languages"
        }
        
        return urlString
    }
    
    func getHTTPMethod() -> String {
        if self == .supportedLanguages {
            return "GET"
        } else {
            return "POST"
        }
    }
}
