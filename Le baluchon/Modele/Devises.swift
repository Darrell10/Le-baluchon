//
//  Devises.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct Devises: Decodable {
    let date: String
    let rates: [String: Double]
}

extension Devises {
    /// Convert Euros in Dollars with update rate
    static func convert(value: Double, with rate: Double) -> String {
        let convertResult = (value * rate)
        return String(format: "%.2f", convertResult)
    }
}
    
   
