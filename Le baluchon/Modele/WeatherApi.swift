//
//  Weather.swift
//  Le baluchon
//
//  Created by Frederick Port on 09/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct WeatherApi: Decodable {
    var name: String
    var coord: [String: Double]
    var weather: Weather
    var base: String
    var main: [String: Double]
    var visibility: String
    var wind: [String: Double]
    var clouds: [String: Double]
    var dt: String
    var sys: Sys
    var timezone: String
    var id: String
    var cod: String
    
}

struct Weather: Decodable {
    var main: String
    var description: String
    var icon: String
}


struct Sys: Decodable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}
