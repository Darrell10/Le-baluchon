//
//  DeviceService.swift
//  Le baluchon
//
//  Created by Frederick Port on 11/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class DeviseService {
    
    func getCurrency(completion: @escaping (Result<[Devises], Error>) -> Void) {
        
        let urlString = "http://data.fixer.io/api/latest?access_key=6cd8ee3ddb7399e53f7b1ab50d44a56c&symbols=USD"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let devise = try JSONDecoder().decode([Devises].self, from: data!)
                completion(.success(devise))
                
            } catch  let jsonError {
                completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}



