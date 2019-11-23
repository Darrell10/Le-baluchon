//
//  DeviceService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class DeviseService {
    
    static var shared = DeviseService()
    private init() {}
    
    private static let fixerUrl = URL(string: "http://data.fixer.io/api/latest?access_key=6cd8ee3ddb7399e53f7b1ab50d44a56c&symbols=USD")!
    
    private var task: URLSessionDataTask?
    private var convertSession = URLSession(configuration: .default)
    
    init(convertSession: URLSession) {
        self.convertSession = convertSession
    }
    
    func getCurrency(completion: @escaping (Result<Devises, Error>) -> Void) {
        var request = URLRequest(url: DeviseService.fixerUrl)
        request.httpMethod = "GET"
        
        /*let body = "latest?access_key=6cd8ee3ddb7399e53f7b1ab50d44a56c&symbols=USD"
        request.httpBody = body.data(using: .utf8)*/
        
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



