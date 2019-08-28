//
//  ConsolidatedWeatherViewModel.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

struct WeatherDayViewModel: WeatherFormatable {
    
    private var consolidatedWeather: ConsolidatedWeather?
    init(consolidatedWeather: ConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
     var weekDayAndDescriptionAttributedString: NSMutableAttributedString? {
        let weatherApplicabledate = consolidatedWeather!.applicableDate
        let weekDay = weatherApplicabledate.getDayOfWeek()
        let weatherDescription = consolidatedWeather!.weatherStateName.capitalized
        let attributedString = NSMutableAttributedString.setupWithText("\(weekDay)", description: "\n" + weatherDescription, textFont: .systemFont(ofSize: 30, weight: .bold), descriptionFont: .systemFont(ofSize: 20, weight: .semibold), textColor: .white, descriptionColor: .white)
        return attributedString
    }
    
    var highLowTemperatureAttributedString: NSMutableAttributedString? {
        
        let highTemperature = consolidatedWeather?.maxTemp ?? 0
        let roundedHighTemperature = Int(highTemperature)
        let lowTemperature = consolidatedWeather?.minTemp ?? 0
        let roundedlowTemperature = Int(lowTemperature)
        
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
    
    var temperatureString: String? {
        let temperature = consolidatedWeather?.theTemp ?? 0
        let roundedTemperature = Int(temperature)
        return addDegreeSign(toNumber: roundedTemperature)
    }

}

protocol WeatherFormatable {
    func floatToPercentageString(float: Float) -> String
    func addUnit(_ unitName: String, toNumber: Float) -> String
}

extension WeatherFormatable {
    
    func floatToPercentageString(float: Float) -> String {
        return "\(Int(float * 100))" + " %"
    }
    
    func addUnit<T>(_ unitName: String, toNumber: T) -> String {
        return "\(toNumber) \(unitName)"
    }
    
    func addDegreeSign<T>(toNumber: T)-> String {
        return "\(toNumber)°"
    }
    
}
