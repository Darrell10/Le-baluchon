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

extension TranslateService {
    
    private func makeRequest(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                task = translateSession.dataTask(with: request) { (results, response, error) in
                    if let error = error {
                        print(error)
                        completion(nil)
                        //completion(.failure(NetWorkError.noData))
                    } else {
                        if let response = response as? HTTPURLResponse, let results = results {
                            if response.statusCode == 200 || response.statusCode == 201 {
                                do {
                                    if let resultsDict = try JSONSerialization.jsonObject(with: results, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {
                                        completion(resultsDict)
                                    }
                                } catch {
                                    //completion(.failure(NetWorkError.jsonError))
                                    print(error.localizedDescription)
                                }
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
                task?.resume()
            }
            
        }
    }
    
    func detectLanguage(forText text: String, completion: @escaping (_ language: String?) -> Void) {
        let urlParams = ["key": apiKey, "q": text] 
        makeRequest(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (results) in
            guard let results = results else { completion(nil); return }
            if let data = results["data"] as? [String: Any], let detections = data["detections"] as? [[[String: Any]]] {
                var detectedLanguages = [String]()
                for detection in detections {
                    for currentDetection in detection {
                        if let language = currentDetection["language"] as? String {
                            detectedLanguages.append(language)
                        }
                    }
                }
                if detectedLanguages.count > 0 {
                    self.sourceLanguageCode = detectedLanguages[0]
                    completion(detectedLanguages[0])
                } else {
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
            
        }
    }
}

struct TranslationLanguage {
    var code: String?
    var name: String?
}

