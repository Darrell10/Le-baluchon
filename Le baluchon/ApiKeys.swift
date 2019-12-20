//
//  ApiKeys.swift
//  Le baluchon
//
//  Created by Frederick Port on 24/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
