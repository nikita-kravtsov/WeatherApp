//
//  LocationDetailViewController.swift
//  WeatherApp
//
//  Created by Никита on 6/6/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dailyTableData = [DailyWeather]()
    var horlyCollectionData = [HourlyWeather]()
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        networkWeatherManager.onCompletionWithCurrentWeather = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(with: currentWeather)
        }
        
        networkWeatherManager.onCompletionWithDailyWeather = { [weak self] dailyWeather in
            guard let self = self else { return }
            self.dailyTableData = dailyWeather
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        networkWeatherManager.onCompletionWithHourlyWeather = { [weak self] hourlyWeather in
            guard let self = self else { return }
            self.horlyCollectionData = hourlyWeather
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        networkWeatherManager.fetchCurrentWeather() 
    }
    
    func updateInterface(with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            
            self.cityLabel.text = currentWeather.currentCityName
            self.weatherLabel.text = currentWeather.currentWeatherDescription
            self.temperatureLabel.text = "\(currentWeather.currentTemperatureString)°"
            self.dayOfWeekLabel.text = currentWeather.currentWeekdayString
            self.dailyHighLabel.text = currentWeather.currentHighTempString
            self.dailyLowLabel.text = currentWeather.currentLowTempString
        }
    }
}

extension LocationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell", for: indexPath) as! DailyTableViewCell
        cell.updateInterface(with: dailyTableData[indexPath.row])
        return cell
    }
}

extension LocationDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horlyCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        hourlyCell.updateInterface(with: horlyCollectionData[indexPath.row])
        return hourlyCell
    }
    
    
}



//func updateInterface(with dailyWeather: DailyWeather) {}

//func updateInterface(with currentWeather: CurrentWeather) {
//       DispatchQueue.main.async {
//
//           let unixDate: TimeInterval = currentWeather.currentWeekday
//           let usableDate = Date(timeIntervalSince1970: unixDate)
//
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "EEEE"
//           dateFormatter.locale = Locale(identifier: "ru_RU")
//
//           let currentDay = dateFormatter.string(from: usableDate)
//
//
//           self.cityLabel.text = currentWeather.currentCityName
//           self.weatherLabel.text = currentWeather.currentWeatherDescription
//           self.temperatureLabel.text = "\(currentWeather.currentTemperatureString)°"
//           self.dayOfWeekLabel.text = currentDay
//           self.dailyHighLabel.text = currentWeather.currentHighTempString
//           self.dailyLowLabel.text = currentWeather.currentLowTempString
//       }
//   }
