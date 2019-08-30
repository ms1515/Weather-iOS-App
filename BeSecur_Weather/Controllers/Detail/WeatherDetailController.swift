//
//  WeatherDetailViewController.swift
//  BeSecur_Weather
//
//  Created by Sheerien Manzoor on 8/28/19.
//  Copyright © 2019 Muhammad Shahrukh. All rights reserved.
//

import UIKit

class WeatherDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let dayDetailCellId = "dayDetailCellId"
    fileprivate let extraDetailCellId = "extraDetailCellId"
    
    var consolidatedWeather: ConsolidatedWeather?
    var woid: Int?
    var location: String?
    
    init(location: String, woid: Int, consolidatedWeather: ConsolidatedWeather) {
        self.woid = woid
        self.location = location
        self.consolidatedWeather = consolidatedWeather
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
    
    func setupTableView() {
        let backView = UIImageView()
        backView.image = UIImage(named: "blueSky")?.withRenderingMode(.alwaysOriginal)
        tableView.backgroundView = backView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.fillSuperview()
    }

    //MARK:- TableView data source
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = WeatherDetailHeader()
        header.weatherDetailHeaderCell.consolidatedWeather = self.consolidatedWeather
        header.weatherDetailHeaderCell.location = self.location
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = WeatherDayPredictionsCell()
            cell.woid = self.woid!
            cell.date = self.consolidatedWeather!.applicableDate
            return cell
        default:
            let cell = WeatherExtraDetailCell()
            cell.consolidatedWeather = self.consolidatedWeather
            cell.woid = self.woid!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 120
        default:
            return UITableView.automaticDimension
        }
    }
}
