//
//  Translate.swift
//  Le baluchon
//
//  Created by Frederick Port on 16/12/2019.
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
