//
//  WeatherDayDetailCell.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayPredictionsCell: UITableViewCell {
    
    var woid: Int? {
        didSet{
            weatherDayPredictionsController.woid = woid!
        }
    }
    var date: String? {
        didSet{
            weatherDayPredictionsController.date = date!
        }
    }
    
    let weatherDayPredictionsController = WeatherDayPredictionsController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let topDividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let bottomDividerLineView: UIView = {
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
        guard let weatherDayPredictionsControllerView = weatherDayPredictionsController.view else {return}
        addSubview(topDividerLineView)
        addSubview(weatherDayPredictionsControllerView)
        addSubview(bottomDividerLineView)
        
        topDividerLineView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, centerX: nil, centerY: nil, size: .init(width: 0, height: 1))
        weatherDayPredictionsControllerView.fillSuperview(padding: .init(top: 1, left: 0, bottom: 1, right: 0))
        bottomDividerLineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, size: .init(width: 0, height: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
