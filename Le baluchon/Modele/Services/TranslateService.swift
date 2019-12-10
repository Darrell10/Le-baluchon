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
    
    static var shared = TranslateService()
    //private init() {}
    
    let apiKey = valueForAPIKey(named:"API_GOOGLE_TRANSLATE_CLIENT_ID")
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

extension TranslateService {
    // Appel reseau avec le type result
    func getDetectionLang(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (Result<GoogleDetection, Error>) -> Void){
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                task = translateSession.dataTask(with: request) { (data, response, error) in
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
                        completion(.failure(NetWorkError.jsonError))
                    }
                }
                task?.resume()
            }
        }
    }
    
    func getLanguageList(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (Result<GoogleLanguage, Error>) -> Void){
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                task = translateSession.dataTask(with: request) { (data, response, error) in
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
                        completion(.failure(NetWorkError.jsonError))
                    }
                }
                task?.resume()
            }
        }
    }
    
    func getTranslation(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (Result<GoogleTranslate, Error>) -> Void){
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                print(request)
                task = translateSession.dataTask(with: request) { (data, response, error) in
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
                        completion(.failure(NetWorkError.jsonError))
                    }
                }
                task?.resume()
            }
        }
    }
}


