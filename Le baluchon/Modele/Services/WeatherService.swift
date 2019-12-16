//
//  WeatherService.swift
//  Le baluchon
//
//  Created by Frederick Port on 26/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class WeatherService {
    
    // MARK: - Property
    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
}

// MARK: - API function

extension WeatherService {
    /// Get weather from openweathermap API
    func getWeather(usingTranslationAPI api: RequestAPI, urlParams: [String: String],completion: @escaping (Result<WeatherApi, Error>) -> Void) {
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            if let url = components.url {
                var request = URLRequest(url: url)
                request.httpMethod = api.getHTTPMethod()
                task = weatherSession.dataTask(with: request) { (data, response, error) in
                    guard let data = data, error == nil else {
                        completion(.failure(NetWorkError.noData))
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(NetWorkError.badUrl))
                        return
                    }
                    do {
                        let weather = try JSONDecoder().decode(WeatherApi.self, from: data)
                        completion(.success(weather))
                    } catch {
                        completion(.failure(NetWorkError.jsonError))
                    }
                }
                task?.resume()
            }
        }
        
    }
}

