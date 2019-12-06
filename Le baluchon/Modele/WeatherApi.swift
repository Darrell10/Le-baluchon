//
//  Weather.swift
//  Le baluchon
//
//  Created by Frederick Port on 09/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct WeatherApi: Decodable {
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let name: String
    let coord: Coord
    let main: Main
    let weather: [Weather]
}

// MARK: - Coord
struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let weatherDescription : String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
