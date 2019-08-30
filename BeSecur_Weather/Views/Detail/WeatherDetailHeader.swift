//
//  WeatherDetailHeader.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDetailHeader: UITableViewHeaderFooterView {
    
    let weatherDetailHeaderCell = WeatherDetailHeaderCell()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        addSubview(weatherDetailHeaderCell)
        weatherDetailHeaderCell.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class WeatherDetailHeaderCell: WeatherHomeCell {
    
    var location: String! {
        didSet{
            locationLabel.text = location
        }
    }
    
    let locationLabel = UILabel(text: "", font: .systemFont(ofSize: 45, weight: .semibold), color: .white)
    
    override func setupViews() {
        
        weekDayAndDescriptionLabel.numberOfLines = 2
        
        addSubview(locationLabel)
        addSubview(weekDayAndDescriptionLabel)
        addSubview(highLowTemperatureLabel)
        addSubview(weatherStateIcon)
        addSubview(temperatureLabel)
        
        locationLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: centerXAnchor, centerY: nil, padding: .init(top: safeAreaInsets.top, left: 0, bottom: 0, right: 0))
        weekDayAndDescriptionLabel.anchor(top: locationLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: 0, right: 0))
        highLowTemperatureLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: 0, left: inset, bottom: inset, right: 0))
        weatherStateIcon.anchor(top: locationLabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: inset), size: .init(width: 70, height: 70))
        temperatureLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: inset, right: inset))
    }
    
}



