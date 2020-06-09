//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Никита on 6/9/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var hourlyImageView: UIImageView!
    @IBOutlet weak var hourlyTemperatureLabel: UILabel!
    
    func updateInterface(with hourlyWeather: HourlyWeather) {
        DispatchQueue.main.async {
            
            self.hourlyLabel.text = hourlyWeather.horlyString
            self.hourlyImageView.image = UIImage(systemName: hourlyWeather.hourlyIconString)
            self.hourlyTemperatureLabel.text = "\(hourlyWeather.hourlyTemperatureString)°"
        }
    }
}
