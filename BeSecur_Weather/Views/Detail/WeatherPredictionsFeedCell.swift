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
            let weatherDayDetailFeedCellViewModel = WeatherHomeCellViewModel(consolidatedWeather: consolidatedWeather)
        }
    }
    
    override func setupViews() {
        backgroundColor = .red
        addSubview(weatherStateIcon)
        addSubview(temperatureLabel)
        weatherStateIcon.centerInSuperview(size: .init(width: 50, height: 50))
        temperatureLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil, centerX: centerXAnchor, centerY: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
    }
}
