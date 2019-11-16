//
//  DeviceService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case domainError
    case decodingError
    
}

class DeviseService {
    
    private let url = URL(string: "http://data.fixer.io/api/latest?access_key=6cd8ee3ddb7399e53f7b1ab50d44a56c&symbols=USD")
}

extension DeviseService {
    
    func getDevises(url: URL, completion: @escaping (Result<[Devises], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            do {
                let devises = try JSONDecoder().decode([Devises].self, from: data)
                completion(.success(devises))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}

