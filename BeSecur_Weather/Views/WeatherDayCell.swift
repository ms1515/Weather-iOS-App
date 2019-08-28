//
//  WeatherDayCell.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayCell: UICollectionViewCell {
    
    var consolidatedWeather: ConsolidatedWeather! {
        didSet {
            let weatherDayViewModel = WeatherDayViewModel(consolidatedWeather: consolidatedWeather)
                weekDayAndDescriptionLabel.attributedText = weatherDayViewModel.weekDayAndDescriptionAttributedString
                weatherStateIcon.image = weatherDayViewModel.weatherImage
                weatherStateIcon.contentMode = .scaleAspectFit
                temperatureLabel.text = weatherDayViewModel.temperatureString
                highLowTemperatureLabel.attributedText = weatherDayViewModel.highLowTemperatureAttributedString
        }
    }
    
    fileprivate let cellRadius: CGFloat = 16
    fileprivate let cellAlpha: CGFloat = 0.9
    fileprivate let inset: CGFloat = 16
    
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
    
    let weekDayAndDescriptionLabel = UILabel(text: "", font: .systemFont(ofSize: 2), numberOfLines: 2, color: nil)
    let highLowTemperatureLabel = UILabel()
    let temperatureLabel = UILabel(text: "", font: .systemFont(ofSize: 30, weight: .semibold), numberOfLines: 1, color: .white)
    let weatherStateIcon = UIImageView(cornerRadius: 0, image: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundView = cellBackgroundView
        addSubview(weekDayAndDescriptionLabel)
        addSubview(highLowTemperatureLabel)
        addSubview(weatherStateIcon)
        addSubview(temperatureLabel)
        weekDayAndDescriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: weatherStateIcon.leadingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: 0, right: 0))
        highLowTemperatureLabel.anchor(top: weekDayAndDescriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: inset, right: 0))
        weatherStateIcon.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: 0, bottom: 0, right: inset), size: .init(width: 70, height: 70))
        temperatureLabel.anchor(top: weatherStateIcon.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: inset))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
