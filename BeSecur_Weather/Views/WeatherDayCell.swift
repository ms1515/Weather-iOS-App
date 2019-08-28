//
//  WeatherDayCell.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayCell: UICollectionViewCell {
    
    var consolidatedWeather: ConsolidatedWeather? {
        didSet {
            if let weatherStateImage = consolidatedWeather?.weatherStateAbbr {
                weatherStateIcon.image = UIImage(named: weatherStateImage)?.withRenderingMode(.alwaysOriginal)
            }

        }
    }
    
    fileprivate let cellRadius: CGFloat = 16
    fileprivate let cellAlpha: CGFloat = 0.9
    fileprivate let inset: CGFloat = 16
    
    lazy var cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "blueSky")?.withRenderingMode(.alwaysOriginal)
        iv.layer.cornerRadius = cellRadius
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.alpha = cellAlpha
        return iv
    }()
    
    let dayLabel = UILabel(text: "Monday", font: .systemFont(ofSize: 24, weight: .bold), numberOfLines: 1, color: .white)
    let highLowTemperatureLabel = UILabel()
    let weatherStateIcon = UIImageView(cornerRadius: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupView()
    }
    
    func setupView() {
        addSubview(cellImageView)
        cellImageView.fillSuperview()
        addSubview(weatherStateIcon)
        weatherStateIcon.fillSuperviewWithTrailingAnchor(trailing: trailingAnchor, padding: .init(top: inset, left: 0, bottom: inset, right: inset), width: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
