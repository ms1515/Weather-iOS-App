//
//  File.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayPredictionsFeedCell: WeatherHomeCell {
    
    override var consolidatedWeather: ConsolidatedWeather! {
        didSet{
            let weatherDayPredictionsFeedCellViewModel = WeatherDayPredictionsFeedCellViewModel(consolidatedWeather: consolidatedWeather)
            temperatureLabel.attributedText = weatherDayPredictionsFeedCellViewModel.temperatureString
            weatherStateIcon.image = weatherDayPredictionsFeedCellViewModel.weatherImage
            predictionTimeLabel.attributedText = weatherDayPredictionsFeedCellViewModel.pastPredictionTimeString
        }
    }
    
    let predictionTimeLabel = UILabel()
    
    override func setupViews() {
        addSubview(predictionTimeLabel)
        addSubview(weatherStateIcon)
        addSubview(temperatureLabel)
        predictionTimeLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: centerXAnchor, centerY: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        weatherStateIcon.centerInSuperview(size: .init(width: 50, height: 50))
        temperatureLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, centerX: centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
    }
}
