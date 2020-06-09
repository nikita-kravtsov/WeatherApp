//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Никита on 6/8/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekHighLabel: UILabel!
    @IBOutlet weak var dailyWeekLowLabel: UILabel!

    func updateInterface(with dailyWeather: DailyWeather) {
        DispatchQueue.main.async {
            
            self.dailyWeekdayLabel.text = dailyWeather.dailyWeekdayString
            self.dailyImageView.image = UIImage(systemName: dailyWeather.dailyIconString)
            self.dailyWeekHighLabel.text = dailyWeather.dailyHighTempString
            self.dailyWeekLowLabel.text = dailyWeather.dailyLowTempString
        }
    }
    
    
    
    
//    var dailyWeather: DailyWeather! {
//        didSet {
//            dailyWeekHighLabel.text = dailyWeather.dailyHighTempString
//            dailyWeekLowLabel.text = dailyWeather.dailyLowTempString
//        }
//    }
    
}
