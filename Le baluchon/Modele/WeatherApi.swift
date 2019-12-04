//
//  Weather.swift
//  Le baluchon
//
//  Created by Frederick Port on 09/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct WeatherApi: Codable {
    let message, cod: String
    let count: Int
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let main: Main
    let dt: Int
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
    let weather: [Weather]
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    let seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main : String
    let weatherDescription : String?
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
