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
    
    private let openWeatherUrl = "http://api.openweathermap.org/data/2.5/"
    private let openWeatherClientID = valueForAPIKey(named:"API_OPENWEATHER_CLIENT_ID")
    private var lat = 40.7306
    private var lon = -73.9867
    private let unit = "metric"
    private let lang = Locale.current.languageCode ?? "en"
    private lazy var url = URL(string: "\(openWeatherUrl)find?lat=\(lat)&lon=\(lon)&APPID=\(openWeatherClientID)&lang=\(lang)&units=\(unit)")
    
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
        guard let weatherUrl = url else { return }
        task = weatherSession.dataTask(with: weatherUrl) { (data, response, error) in
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
    
    func getUserWeather (_ lat: Double, _ lon: Double, completion: @escaping (Result<WeatherApi, Error>) -> Void) {
        let urlUserRequest = URL(string: "\(openWeatherUrl)find?lat=\(lat)&lon=\(lon)&APPID=\(openWeatherClientID)&lang=\(lang)&units=\(unit)")
        guard let urlUser = urlUserRequest else { return }
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
                    let weatherUser = try JSONDecoder().decode(WeatherApi.self, from: data)
                    completion(.success(weatherUser))
                } catch {
                    completion(.failure(NetWorkError.jsonError))
                }
        }
        task?.resume()
    }
}

