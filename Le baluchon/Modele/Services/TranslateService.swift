//
//  TranslateService.swift
//  Le baluchon
//
//  Created by Frederick Port on 05/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class TranslateService: NSObject {
    
    // MARK: - Property
    
    static let shared = TranslateService()
    
    private let apiKey = valueForAPIKey(named:"API_GOOGLE_TRANSLATE_CLIENT_ID")
    var sourceLanguageCode: String?
    var supportedLanguages = [TranslationLanguage]()
    var textToTranslate: String?
    var targetLanguageCode: String?
    
    private var task: URLSessionDataTask?
    private var translateSession: URLSession
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
}

// MARK: - API function

/*extension TranslateService {
    /// Get Currency from Fixer API
    func getTranslate(completion: @escaping (Result<TranslationAPI, Error>) -> Void) {
        guard let urlData = url else { return }
        task = translateSession.dataTask(with: urlData) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetWorkError.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetWorkError.badUrl))
                return
            }
            do {
                //let devise = try JSONDecoder().decode(TranslationAPI.self, from: data)
                //completion(.success(devise))
            } catch {
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
}*/

struct TranslationLanguage {
    var code: String?
    var name: String?
}

