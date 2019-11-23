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
    static func convert(_ value: Double, with rate: Double) -> String {
        let convertResult = (value * rate)
        return String(format: "%.2f", convertResult)
    }
}
    
   
