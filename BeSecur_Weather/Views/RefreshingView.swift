//
//  RefreshingView.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class RefreshView: UIView {
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.startAnimating()
        return aiv
    }()
    
    let infoLabel = UILabel(text: "Reloading Data", font: .systemFont(ofSize: 20, weight: .medium), numberOfLines: 1, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(activityIndicatorView)
        addSubview(infoLabel)
        activityIndicatorView.centerInSuperview()
        infoLabel.anchor(top: activityIndicatorView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, centerX: centerXAnchor, centerY: nil)
    }
}
