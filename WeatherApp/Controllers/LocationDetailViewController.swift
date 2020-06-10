//
//  LocationDetailViewController.swift
//  WeatherApp
//
//  Created by Никита on 6/6/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit
import CoreLocation

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
    
    var latitude: CLLocationDegrees = 53.899674
    var longitude: CLLocationDegrees = 27.553996
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
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
        
        networkWeatherManager.fetchCurrentWeather(latitude: latitude, longitude: longitude)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
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

//MARK: - UITableViewDelegate, UITableViewDataSource
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
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


// MARK: - CLLocationManagerDelegate
extension LocationDetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let coordinate = location.coordinate
        
        print("latitude: \(coordinate.latitude)")
        print("longitude: \(coordinate.longitude)")
        
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        
        
        networkWeatherManager.fetchCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription )
    }
}
