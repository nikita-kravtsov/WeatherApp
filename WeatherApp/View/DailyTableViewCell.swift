//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Никита on 6/8/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import UIKit

class DailyTableViewCell: LocationDetailViewController {

    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekHighLabel: UILabel!
    @IBOutlet weak var dailyWeekLowLabel: UILabel!

    override func updateInterface(with dailyWeather: DailyWeather) {
        DispatchQueue.main.async {
        
            let unixDate: TimeInterval = dailyWeather.dailyWeekday
            let usableDate = Date(timeIntervalSince1970: unixDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = Locale(identifier: "ru_RU")
            
            let dailyWeekday = dateFormatter.string(from: usableDate)
            
            self.dailyWeekdayLabel.text = dailyWeekday
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
