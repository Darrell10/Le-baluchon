//
//  WeatherService.swift
//  Le baluchon
//
//  Created by Frederick Port on 26/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - Property
    
    private let openWeatherUrl = "http://api.openweathermap.org/data/2.5/"
    private let openWeatherClientID = valueForAPIKey(named:"API_OPENWEATHER_CLIENT_ID")
    private let openWeatherCity = "New%20York"
    private let lat = 47.3167
    private let lon = 5.0167
    private let unit = "metric"
    private let lang = Locale.current.languageCode ?? "en"
    
    private lazy var url = URL(string: "\(openWeatherUrl)find?q=\(openWeatherCity)&APPID=\(openWeatherClientID)&lang=\(lang)&units=\(unit)")
    private lazy var urlrequest = URL(string: "\(openWeatherUrl)find?lat=\(lat)&lon=\(lon)&APPID=\(openWeatherClientID)&lang=\(lang)&units=\(unit)")
    
    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
}

// MARK: - API function

extension WeatherService {
    /// Get weather from openweathermap API
    func getNYWeather(completion: @escaping (Result<WeatherApi, Error>) -> Void) {
        guard let urlTest = url else { return }
        task = weatherSession.dataTask(with: urlTest) { (data, response, error) in
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
                print(weather)
            } catch {
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
    
    func getUserWeather (_ lat: Double, _ lon: Double, completion: @escaping (Result<WeatherApi, Error>) -> Void) {
        guard let urlUser = urlrequest else { return }
        task = weatherSession.dataTask(with: urlUser) { (data, response, error) in
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
                print(weather)
            } catch {
                completion(.failure(NetWorkError.jsonError))
            }
        }
        task?.resume()
    }
}

