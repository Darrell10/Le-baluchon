//
//  DeviceService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class DeviseService {

// MARK: - Property
    
    static var shared = DeviseService()
    private init() {}
    
    private static let url = "http://data.fixer.io/api/latest?access_key="
    private static let clientID = valueForFixerAPIKey(named:"API_FIXER_CLIENT_ID")
    private static let fixerParameter = "&symbols=USD"
    private static let fixerUrl = URL(string: "\(url)" + "\(clientID)" + "\(fixerParameter)")!
    
    private var task: URLSessionDataTask?
    private var convertSession = URLSession(configuration: .default)
    
    init(convertSession: URLSession) {
        self.convertSession = convertSession
    }
}

// MARK: - API function

extension DeviseService {
    /// Get Currency from Fixer API
    func getCurrency(completion: @escaping (Result<Devises, Error>) -> Void) {
        var request = URLRequest(url: DeviseService.fixerUrl)
        request.httpMethod = "GET"
        task = convertSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
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
        }
        task?.resume()
    }
}



