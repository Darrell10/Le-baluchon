//
//  CurrencyService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class CurrencyService: MapperEncoder {
    
    // MARK: - Property
    
    private var task: URLSessionDataTask?
    private var convertSession: URLSession
    
    init(convertSession: URLSession = URLSession(configuration: .default)) {
        self.convertSession = convertSession
    }
}

// MARK: - API function

extension CurrencyService {
    /// Get Currency from Fixer API
    func getCurrency(currency: String, completion: @escaping (Result<Devises, Error>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?") else { return }
        let params = ["access_key": ApiConfig.fixerKey, "symbols": "\(currency)"]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        task?.cancel()
        task = convertSession.dataTask(with: urlEncoded) { (data, response, error) in
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
                print(error.localizedDescription)
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
}




