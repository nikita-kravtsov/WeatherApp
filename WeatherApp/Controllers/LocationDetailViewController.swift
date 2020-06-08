//
//  LocationDetailViewController.swift
//  WeatherApp
//
//  Created by Никита on 6/6/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

let dateFormatter: DateFormatter = {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
}()


class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(with: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather() 
    }
    
    func updateInterface(with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            
            
            self.cityLabel.text = currentWeather.cityName
            self.weatherLabel.text = currentWeather.weatherDescription
            self.temperatureLabel.text = "\(currentWeather.temperatureString)°"
            self.dayOfWeekLabel.text = currentWeather.dayOfWeekString
            self.dailyHighLabel.text = currentWeather.dayTempString
            self.dailyLowLabel.text = currentWeather.nightTempString
        }
    }
}
