//
//  Weather.swift
//  Le baluchon
//
//  Created by Frederick Port on 09/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct WeatherApi: Decodable {
    let message : String?
    let cod: String
    let count: Int
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let main: Main
    let dt: Int
    let wind: Wind
    let sys: Sys
    let rain: Rain?
    let clouds: Clouds
    let weather: [Weather]
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Decodable {
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

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let country: String
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int?
}


