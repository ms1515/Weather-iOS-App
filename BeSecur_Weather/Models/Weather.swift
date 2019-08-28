//
//  LocationSearch.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let consolidatedWeather: [ConsolidatedWeather]
    let time, sunRise, sunSet, timezoneName: String
    let parent: Parent
    let sources: [Source]
    let title, locationType: String
    let woeid: Int
    let lattLong, timezone: String
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case time
        case sunRise = "sun_rise"
        case sunSet = "sun_set"
        case timezoneName = "timezone_name"
        case parent, sources, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
        case timezone
    }
}

struct Parent: Codable {
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

struct Source: Codable {
    let title, slug: String
    let url: String
    let crawlRate: Int
    
    enum CodingKeys: String, CodingKey {
        case title, slug, url
        case crawlRate = "crawl_rate"
    }
}
