//
//  TranslateService.swift
//  Le baluchon
//
//  Created by Frederick Port on 05/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class TranslateService {
    
    // MARK: - Property
    
    weak var delegateDisplay: DisplayDelegate?
    
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
    
    func detectionLang(forText text: String) {
        let urlParams = ["key": apiKey, "q": text]
        getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    print(results)
                    guard let data = results.data.detections.first else { return }
                    guard let language = data.first?.language else { return }
                    self.delegateDisplay?.presentAlert(title: "Detection de la langue", message: "Le langage suivant a été détecté:\n\n\(language)")
                case .failure:
                    self.delegateDisplay?.presentAlert(title: "Detection de la langue", message: "Oops! le language n'a pas été détecté.")
                }
            }
        }
    }
}

protocol DisplayDelegate: class {
    func presentAlert(title: String, message: String)
}




