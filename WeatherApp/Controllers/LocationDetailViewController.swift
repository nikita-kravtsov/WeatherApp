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
    
    
    

    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(with: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather() 
    }
    
    func updateInterface(with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            
            let unixDate: TimeInterval = currentWeather.currentWeekday
            let usableDate = Date(timeIntervalSince1970: unixDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            
            let currentDay = dateFormatter.string(from: usableDate)
            
            
            self.cityLabel.text = currentWeather.currentCityName
            self.weatherLabel.text = currentWeather.currentWeatherDescription
            self.temperatureLabel.text = "\(currentWeather.currentTemperatureString)°"
            self.dayOfWeekLabel.text = currentDay
            self.dailyHighLabel.text = currentWeather.currentHighTempString
            self.dailyLowLabel.text = currentWeather.currentLowTempString
        }
    }
}

//extension LocationDetailViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
