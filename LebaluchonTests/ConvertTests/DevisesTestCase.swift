//
//  DevisesTestCase.swift
//  LebaluchonTests
//
//  Created by Frederick Port on 23/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import XCTest
@testable import Le_baluchon

class DevisesTestCase: XCTestCase {
    func testGivenValue3Rate1ConvertShouldReturn3() {
        let value = 3.0
        let rate = 1.00
        let result = Devises.convert(value, with: rate)
        XCTAssertEqual(result, "3.00")
    }
}
