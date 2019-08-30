//
//  WeatherExtraDetailViewModel.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherExtraDetailCellViewModel: WeatherFormatable {
    
    private var consolidatedWeather: ConsolidatedWeather?
    init(consolidatedWeather: ConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
    fileprivate let textFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    fileprivate let descriptionFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    var windLabelAttributedString: NSMutableAttributedString? {
        let windDirection = consolidatedWeather?.windDirectionCompass ?? "-"
        let windSpeed = Int(consolidatedWeather?.windSpeed ?? 0)
        let attributedString = NSMutableAttributedString.setupWithText("WIND", description: "\n" + windDirection + " \(windSpeed)" + " mph", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
    var humidityLabelAttributedString: NSMutableAttributedString? {
        let humidity = consolidatedWeather?.humidity ?? 0
        let attributedString = NSMutableAttributedString.setupWithText("HUMIDITY", description: "\n\(humidity)%", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
    var visibilityLabelAttributedString: NSMutableAttributedString? {
        var visibility = consolidatedWeather?.visibility ?? 0
        let roundedVisibility = visibility.roundToPlaces(places: 1)
        let attributedString = NSMutableAttributedString.setupWithText("VISIBILITY", description: "\n\(roundedVisibility) km", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
    var airPressureLabelAttributedString: NSMutableAttributedString? {
        let airPressure = consolidatedWeather?.airPressure ?? 0
        let roundedPressure = Int(round(airPressure))
        let attributedString = NSMutableAttributedString.setupWithText("PRESSURE", description: "\n \(roundedPressure) hPa", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
}
