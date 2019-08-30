//
//  WeatherDayDetailController.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/29/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDayPredictionsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let inset: CGFloat = 20
    fileprivate let predictionFeedCellId = "cellId"
    
    var woid: Int?
    var date: String? {
        didSet {
            searchDayWeatherForLocation()
        }
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .white)
        aiv.startAnimating()
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        setupCollectionView()
        registerCells()
    }
    
    func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = inset
            layout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func registerCells() {
        collectionView.register(WeatherDayPredictionsFeedCell.self, forCellWithReuseIdentifier: predictionFeedCellId)
    }
    
    var consolidatedWeather = [ConsolidatedWeather]()
    
    func searchDayWeatherForLocation() {
        
        guard let woid = self.woid else {return}
        guard let date = self.date else {return}
        let woidString = String(woid)
        let dateString = date.formatStringToDateType()
        
        Service().fetchLocationDayWeather(woid: woidString, date: dateString) { (consolidatedWeather, error) in
            if let error = error {
                print(error)
                return
            }
            guard let consolidatedWeather = consolidatedWeather else {return}
            self.consolidatedWeather = consolidatedWeather
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        activityIndicatorView.isHidden = consolidatedWeather.count != 0
        return consolidatedWeather.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: predictionFeedCellId, for: indexPath) as! WeatherDayPredictionsFeedCell
        cell.consolidatedWeather = consolidatedWeather[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 4
        let height = view.frame.height 
        return .init(width: width, height: height)
    }
    
    //MARK:- Weather Prediction Feed Cell Animation
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 10, 0, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    
}
