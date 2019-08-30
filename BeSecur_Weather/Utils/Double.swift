//
//  Double.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

extension Double {
    /// Rounds the double to specified decimal place value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let value = self * divisor
        let roundedValue = Darwin.round(value) / divisor
        return roundedValue
    }
}
