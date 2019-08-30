//
//  WeatherExtraDetailCell.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherExtraDetailCell: UITableViewCell {
    
    var consolidatedWeather: ConsolidatedWeather! {
        didSet {
            let weatherExtraDetailCellViewModel = WeatherExtraDetailCellViewModel(consolidatedWeather: consolidatedWeather)
            windLabel.attributedText = weatherExtraDetailCellViewModel.windLabelAttributedString
            humidityLabel.attributedText = weatherExtraDetailCellViewModel.humidityLabelAttributedString
            visibilityLabel.attributedText = weatherExtraDetailCellViewModel.visibilityLabelAttributedString
            airPressureLabel.attributedText = weatherExtraDetailCellViewModel.airPressureLabelAttributedString
        }
    }
    
    var woid: Int?
    
    let inset: CGFloat = 16
    
    let windLabel = UILabel()
    let humidityLabel = UILabel()
    let visibilityLabel = UILabel()
    let airPressureLabel = UILabel()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    func setupViews() {
        windLabel.numberOfLines = 0
        humidityLabel.numberOfLines = 0
        visibilityLabel.numberOfLines = 0
        airPressureLabel.numberOfLines = 0
        
        addSubview(windLabel)
        addSubview(humidityLabel)
        addSubview(dividerLineView)
        addSubview(visibilityLabel)
        addSubview(airPressureLabel)
        windLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: centerXAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: inset, right: 0))
        humidityLabel.anchor(top: topAnchor, leading: centerXAnchor, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: inset, right: inset))
        dividerLineView.anchor(top: windLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: 0, right: inset), size: .init(width: 0, height: 0.5))
        visibilityLabel.anchor(top: dividerLineView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: centerXAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: inset, right: 0))
        airPressureLabel.anchor(top: dividerLineView.bottomAnchor, leading: centerXAnchor, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, padding: .init(top: inset, left: inset, bottom: inset, right: inset))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
