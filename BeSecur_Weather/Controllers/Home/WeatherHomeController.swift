//
//  ViewController.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/27/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherHomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, UISearchBarDelegate {
    
    fileprivate let horizantalInset: CGFloat = 20
    fileprivate let verticalInset: CGFloat = 20
    fileprivate let lineSpacing: CGFloat = 40
    
    fileprivate let homeCellId = "homeCellId"
    
    var location = String()
    var woid = Int()
    
    fileprivate let backgroundImageView = UIImageView(cornerRadius: 0, image: "blueSky")
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let reloadView =  ReloadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(reloadView)
        reloadView.centerInSuperview()
        setupSearchBar()
        setupRefreshControl()
        setupCollectionView()
        searchLocation(location: "Belfast")
    }
    
    fileprivate func setupSearchBar() {
        let navBar = self.navigationController?.navigationBar
        navBar?.barStyle = .black
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        forecasts.removeAll()
        collectionView.reloadData()
        if let locationString = searchBar.text, !locationString.isEmpty {
            searchLocation(location: locationString)
        }
    }

    // MARK:- Setting up Refresh Control
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
    
    //MARK:- API Service
    var forecasts = [ConsolidatedWeather]()
    
    func searchLocation(location: String) {
        Service().searchLocationWOID(location: location) { (location, error) in
            if let error = error {
                print(error)
                return
            }
            guard let location = location else { return }
            let woid = location[0].woeid
            self.woid = woid
            self.location = location[0].title
            self.fetchWeatherforLocation(woid: woid)
        }
    }
    
    func fetchWeatherforLocation(woid: Int) {
        let woid = String(woid)
        Service().fetchLocationWeather(woid: woid) { (weather, error) in
            if let error = error {
                print(error)
                return
            }
            guard let weather = weather else {return}
            let consolidatedWeather = weather.consolidatedWeather
            self.forecasts = consolidatedWeather
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.setupNavBar()
            }
        }
    }
    
    func setupNavBar() {
        title = location
    }
    
    //MARK:- Setting up CollectionView
    func setupCollectionView() {
        collectionView.backgroundView = backgroundImageView
        collectionView.contentInset = .init(top: verticalInset, left: horizantalInset, bottom: 3 * verticalInset, right: horizantalInset)
        collectionView.register(WeatherHomeCell.self, forCellWithReuseIdentifier: homeCellId)
    }
    
    //MARK:- CollectionView Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reloadView.isHidden = forecasts.count != 0
        return forecasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath) as! WeatherHomeCell
        cell.consolidatedWeather = forecasts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * horizantalInset
        return .init(width: width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    //MARK:- Weather Home Cell Animation
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    //MARK:- Weather Detail Controller View Animation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let consolidatedWeather = self.forecasts[indexPath.item]
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        setupWeatherDetailViewAnimation(consolidatedWeather: consolidatedWeather, frame: startingFrame)
    }
    
    var startingFrame: CGRect?
    var weatherDetailController: WeatherDetailController!
    var anchoredConstraints: AnchoredConstraints?
    
    func setupWeatherDetailViewAnimation(consolidatedWeather: ConsolidatedWeather, frame: CGRect) {
        self.startingFrame = frame
        let weatherDetailController = WeatherDetailController(location: self.location, woid: self.woid, consolidatedWeather: consolidatedWeather)
    
        guard let weatherDetailView = weatherDetailController.view else {return}
        weatherDetailView.layer.cornerRadius = 16
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        weatherDetailView.addGestureRecognizer(gesture)
        
        view.addSubview(weatherDetailView)
        self.weatherDetailController = weatherDetailController
        
        self.anchoredConstraints = weatherDetailView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: nil, padding: .init(top: frame.origin.y, left: frame.origin.x, bottom: 0, right: 0), size: .init(width: frame.width, height: frame.height))
        
        self.view.layoutIfNeeded()
        self.collectionView.isUserInteractionEnabled = false
        animateWeatherDetailView()
    }
    
    fileprivate func animateWeatherDetailView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let viewFrame = self?.view.frame else {return}
            self?.anchoredConstraints?.top?.constant = 0
            self?.anchoredConstraints?.leading?.constant = 0
            self?.anchoredConstraints?.width?.constant = viewFrame.width
            self?.anchoredConstraints?.height?.constant = viewFrame.height
            self?.weatherDetailController.view.layer.cornerRadius = 16
            self?.view.layoutIfNeeded() // starts animation
            self?.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
            self?.navigationItem.searchController = nil
        }) { (_) in
        }
    }
    
    @objc func dismissWeatherDetailView() {
        self.weatherDetailController.view?.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.weatherDetailController?.tableView.contentOffset = .zero
            guard let startingFrame = self?.startingFrame else {return}
            let startingFrameYCenter = startingFrame.origin.y + startingFrame.height/2
            self?.anchoredConstraints?.top?.constant = startingFrameYCenter
            self?.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self?.anchoredConstraints?.width?.constant = startingFrame.width
            self?.anchoredConstraints?.height?.constant = 0
            self?.view.layoutIfNeeded()
            self?.weatherDetailController.view.layer.cornerRadius = 16
            self?.weatherDetailController.view.alpha = 0.5
            self?.navigationController?.navigationBar.transform = .identity
            self?.navigationItem.searchController = self?.searchController
        }) { [weak self] (_) in
            self?.weatherDetailController.view.removeFromSuperview()
            self?.collectionView.isUserInteractionEnabled = true
        }
    }
    
    var fullViewBeginOffset: CGFloat = 0
    
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            fullViewBeginOffset = weatherDetailController.tableView.contentOffset.y
        }
        let translationY = gesture.translation(in: weatherDetailController?.view).y
        switch gesture.state {
        case .changed:
            if translationY > 0 {
                let trueOffset = translationY - fullViewBeginOffset
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.weatherDetailController?.view.transform = transform
                self.weatherDetailController?.view.layer.cornerRadius = 16 * scale
            }
        case .ended:
            if translationY > 0 {
                dismissWeatherDetailView()
            } else {
                self.weatherDetailController?.view.layer.cornerRadius = 0
            }
        default:
            return
        }
    }

}

