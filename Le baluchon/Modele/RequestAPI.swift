//
//  Translate.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation


// MARK: - Enum Request API

enum RequestAPI {
    case detectLanguage
    case translate
    case supportedLanguages
    case currency
    case weather
    
    func getURL() -> String {
        var urlString = ""
        
        switch self {
        case .detectLanguage:
            urlString = "https://translation.googleapis.com/language/translate/v2/detect"
        case .translate:
            urlString = "https://translation.googleapis.com/language/translate/v2"
        case .supportedLanguages:
            urlString = "https://translation.googleapis.com/language/translate/v2/languages"
        case .currency:
            urlString = "http://data.fixer.io/api/latest?"
        case .weather:
            urlString = "http://api.openweathermap.org/data/2.5/find"
            
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
