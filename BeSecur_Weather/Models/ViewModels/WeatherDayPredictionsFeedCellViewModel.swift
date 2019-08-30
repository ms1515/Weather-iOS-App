//
//  WeatherDayDetailFeedCellViewModel.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/30/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayPredictionsFeedCellViewModel: WeatherFormatable {
    
    private var consolidatedWeather: ConsolidatedWeather?
    init(consolidatedWeather: ConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
    fileprivate let textFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    fileprivate let descriptionFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    
    var pastPredictionTimeString: NSMutableAttributedString? {
        let weatherCreatedTime = consolidatedWeather?.created
        let weatherCreatedHour = weatherCreatedTime?.createHourFromDateString() ?? 00
        let attributedString = NSMutableAttributedString.setupWithText("\(weatherCreatedHour)", description: "", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
    var weatherImage: UIImage? {
        if let imageIconName = consolidatedWeather?.weatherStateAbbr {
            return UIImage(named: imageIconName)
        }
        return nil
    }
    
    var temperatureString: NSMutableAttributedString? {
        let temperature = consolidatedWeather?.theTemp ?? 0
        let roundedTemperature = Int(round(temperature))
        let formattedTemperature =  addDegreeSign(toNumber: roundedTemperature)
        let attributedString = NSMutableAttributedString.setupWithText("\(formattedTemperature)", description: "", textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
}
