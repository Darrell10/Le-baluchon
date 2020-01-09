//
//  TranslateService.swift
//  Le baluchon
//
//  Created by Frederick Port on 05/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class TranslateService: MapperEncoder {
    
    // MARK: - Property
    
    private var task: URLSessionDataTask?
    private var translateSession: URLSession
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
}

// MARK: - API function

extension TranslateService {
    /// Get detection language from Google Translate API
    func getDetectionLang(text:String, completion: @escaping (Result<GoogleDetection, Error>) -> Void){
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2/detect") else { return }
        let params = ["key": ApiConfig.googleKey, "q": "\(text)"]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        task = translateSession.dataTask(with: urlEncoded) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetWorkError.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetWorkError.badUrl))
                return
            }
            do {
                let results = try JSONDecoder().decode(GoogleDetection.self, from: data)
                completion(.success(results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
    
    /// Get language list from Google Translate API
    func getLanguageList(completion: @escaping (Result<GoogleLanguage, Error>) -> Void){
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2/languages") else { return }
        let params = ["key": ApiConfig.googleKey, "target": Locale.current.languageCode ?? "en"]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        task = translateSession.dataTask(with: urlEncoded) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetWorkError.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetWorkError.badUrl))
                return
            }
            do {
                let results = try JSONDecoder().decode(GoogleLanguage.self, from: data)
                completion(.success(results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
    
    /// Get translation from Google Translate API
    func getTranslation(text:String, code: String, completion: @escaping (Result<GoogleTranslate, Error>) -> Void){
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2") else { return }
        let params = ["key": ApiConfig.googleKey, "target": "\(code)", "format": "text", "q": "\(text)"]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        task = translateSession.dataTask(with: urlEncoded) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetWorkError.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetWorkError.badUrl))
                return
            }
            do {
                let results = try JSONDecoder().decode(GoogleTranslate.self, from: data)
                completion(.success(results))
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }    
}

// MARK: - Language back Protocol

protocol LanguageDelegate {
    func passLanguageBack(_ languageCode: String)
}
