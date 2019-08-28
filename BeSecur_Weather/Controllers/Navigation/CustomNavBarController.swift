//
//  CustomNavBarController.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherCustomNavController: UINavigationController, UINavigationControllerDelegate {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
        setupNavBar()
    }
    
    func setupNavBar() {
        let navBar = self.navigationBar
        navBar.barStyle = .black
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.prefersLargeTitles = true
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
