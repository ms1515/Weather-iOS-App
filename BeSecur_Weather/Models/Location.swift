//
//  Weather.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import Foundation

struct Location: Codable {

    let title, locationType: String
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    } 

}


