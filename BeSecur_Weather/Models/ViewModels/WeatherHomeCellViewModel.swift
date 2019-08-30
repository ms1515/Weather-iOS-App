//
//  ConsolidatedWeatherViewModel.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

struct WeatherHomeCellViewModel: WeatherFormatable {
    
    private var consolidatedWeather: ConsolidatedWeather?
    init(consolidatedWeather: ConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
    fileprivate let textFont = UIFont.systemFont(ofSize: 30, weight: .bold)
    fileprivate let descriptionFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    var weekDayAndDescriptionAttributedString: NSMutableAttributedString? {
        let weatherApplicabledate = consolidatedWeather!.applicableDate
        let weatherDescription = consolidatedWeather!.weatherStateName.capitalized
        let weekDay = weatherApplicabledate.getDayOfWeek()
        if weekDay.isTheDayToday() {
            let attributedString = NSMutableAttributedString.setupWithText("\(weekDay)", description: "\n" + "TODAY,  " + weatherDescription, textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
            return attributedString
        } else {
            let attributedString = NSMutableAttributedString.setupWithText("\(weekDay)", description: "\n" + weatherDescription, textFont: textFont, descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
            return attributedString
        }
    }
    
    var highLowTemperatureAttributedString: NSMutableAttributedString? {
        
        let highTemperature = consolidatedWeather?.maxTemp ?? 0
        let roundedHighTemperature = Int(round(highTemperature))
        let lowTemperature = consolidatedWeather?.minTemp ?? 0
        let roundedlowTemperature = Int(round(lowTemperature))
        
        let attributedText = NSMutableAttributedString(string: "High: \(roundedHighTemperature)°", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "  Low: \(roundedlowTemperature)°", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        return attributedText
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
        let attributedString = NSMutableAttributedString.setupWithText("\(formattedTemperature)", description: "", textFont: .systemFont(ofSize: 30, weight: .semibold), descriptionFont: descriptionFont, textColor: .white, descriptionColor: .white)
        return attributedString
    }

}

