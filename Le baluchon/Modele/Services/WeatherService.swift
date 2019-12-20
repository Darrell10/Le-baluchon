//
//  WeatherService.swift
//  Le baluchon
//
//  Created by Frederick Port on 26/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

final class WeatherService: MapperEncoder {
    
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
    func getWeather(lat: String, lon: String, completion: @escaping (Result<WeatherApi, Error>) -> Void) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/find") else { return }
        let params = ["APPID": valueForAPIKey(named:"API_OPENWEATHER_CLIENT_ID"), "lang": Locale.current.languageCode ?? "en", "units": "metric", "lat": "\(lat)", "lon": "\(lon)"]
        let urlEncoded = encode(baseUrl: url, parameters: params)
        task = weatherSession.dataTask(with: urlEncoded) { (data, response, error) in
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

