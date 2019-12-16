//
//  DeviceService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class DeviseService {
    
    // MARK: - Property
    
    private var task: URLSessionDataTask?
    private var convertSession: URLSession
    
    init(convertSession: URLSession = URLSession(configuration: .default)) {
        self.convertSession = convertSession
    }
}

// MARK: - API function

extension DeviseService {
    /// Get Currency from Fixer API
    func getCurrency(usingTranslationAPI api: RequestAPI, urlParams: [String: String], completion: @escaping (Result<Devises, Error>) -> Void) {
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                task = convertSession.dataTask(with: request) { (data, response, error) in
                    guard let data = data, error == nil else {
                        completion(.failure(NetWorkError.noData))
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(NetWorkError.badUrl))
                        return
                    }
                    do {
                        let devise = try JSONDecoder().decode(Devises.self, from: data)
                        completion(.success(devise))
                    } catch {
                        completion(.failure(NetWorkError.jsonError))
                    }
                }
                task?.resume()
            }
        }
    }
}



