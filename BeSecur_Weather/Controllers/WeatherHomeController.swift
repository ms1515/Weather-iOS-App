//
//  ViewController.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherHomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let horizantalInset: CGFloat = 20
    fileprivate let verticalInset: CGFloat = 20
    fileprivate let lineSpacing: CGFloat = 40
    
    fileprivate let cellId = "cellId"
    var location = "Belfast"
    
    let backgroundImageView = UIImageView(cornerRadius: 0, image: "blueSky")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupNavBar()
        setupCollectionView()
        searchLocation(location: location)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    @objc func handleRefresh() {
        forecasts.removeAll()
        collectionView?.reloadData()
        searchLocation(location: location)
        collectionView?.refreshControl?.endRefreshing()
    }
    
    func searchLocation(location: String) {
        Service().searchLocationWOID(location: location) { (location, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let location = location else {return}
            let locationWoid = location[0].woeid
            self.fetchWeatherforLocation(locationWoid: locationWoid)
        }
    }
    
    func fetchWeatherforLocation(locationWoid: Int) {
        let woid = String(locationWoid)
        Service().fetchLocationWeather(locationWoid: woid) { (weather, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let weather = weather else {return}
            let consolidatedWeather = weather.consolidatedWeather
            print(consolidatedWeather)
            self.forecasts = consolidatedWeather
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    var forecasts = [ConsolidatedWeather]()
    
    func setupNavBar() {
        title = location
    }

    func setupCollectionView() {
        collectionView.backgroundView = backgroundImageView
        collectionView.contentInset = .init(top: verticalInset, left: horizantalInset, bottom: 3 * verticalInset, right: horizantalInset)
        collectionView.register(WeatherDayCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(RefreshView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "id")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UIView {
        let footerView = RefreshView()
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerViewSize = CGSize(width: view.frame.width, height: 200)
        return forecasts.isEmpty ? footerViewSize : .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherDayCell
        cell.consolidatedWeather = forecasts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * horizantalInset
        return .init(width: width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }


}

