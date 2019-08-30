//
//  WeatherDayCell.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherHomeCell: UICollectionViewCell {
    
    var consolidatedWeather: ConsolidatedWeather! {
        didSet {
            let weatherHomeCellViewModel = WeatherHomeCellViewModel(consolidatedWeather: consolidatedWeather)
                weekDayAndDescriptionLabel.attributedText = weatherHomeCellViewModel.weekDayAndDescriptionAttributedString
                weatherStateIcon.image = weatherHomeCellViewModel.weatherImage
                weatherStateIcon.contentMode = .scaleAspectFit
                temperatureLabel.attributedText = weatherHomeCellViewModel.temperatureString
                highLowTemperatureLabel.attributedText = weatherHomeCellViewModel.highLowTemperatureAttributedString
        }
    }
    
    let cellRadius: CGFloat = 16
    let cellAlpha: CGFloat = 0.9
    let inset: CGFloat = 16
    
    lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = cellRadius
        view.dropShadow(color: .black, opacity: 0.3, offSet: .init(width: 0, height: 10), radius: 10)
        view.backgroundColor = .white
        let cellImageView =  UIImageView(cornerRadius: cellRadius, image: "blueSky")
        view.addSubview(cellImageView)
        cellImageView.fillSuperview()
        return view
    }()
    
    let weekDayAndDescriptionLabel = UILabel()
    let highLowTemperatureLabel = UILabel()
    let temperatureLabel = UILabel()
    let weatherStateIcon = UIImageView(cornerRadius: 0, image: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundView = cellBackgroundView
        weekDayAndDescriptionLabel.numberOfLines = 2
        addSubview(weekDayAndDescriptionLabel)
        addSubview(highLowTemperatureLabel)
        addSubview(weatherStateIcon)
        addSubview(temperatureLabel)
        weekDayAndDescriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: 0, right: 0))
        highLowTemperatureLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: 0, left: inset, bottom: inset, right: 0))
        weatherStateIcon.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: 0, bottom: 0, right: inset), size: .init(width: 70, height: 70))
        temperatureLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: inset, right: inset))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
