//
//  Devises.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

struct Devises: Decodable {
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}
    
   
