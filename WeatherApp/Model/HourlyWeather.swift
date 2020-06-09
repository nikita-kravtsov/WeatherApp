//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/9/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct HourlyWeather {
    
    let hourly: TimeInterval
    var horlyString: String {
        
        let unixDate: TimeInterval = hourly
        let usableDate = Date(timeIntervalSince1970: unixDate)
        
        let hourlyFormatter = DateFormatter()
        hourlyFormatter.dateFormat = "ha"
        
        return hourlyFormatter.string(from: usableDate)
    }
    
    let hourlyIcon: Int
    var hourlyIconString: String {
        switch hourlyIcon {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "cloud.fog.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    let hourlyTemperature: Double
    var hourlyTemperatureString: String {
        return String(format: "%.0f", hourlyTemperature)
    }
    
    init?(hourly: Hourly) {
        self.hourly = hourly.dt
        self.hourlyIcon = hourly.weather.first!.id
        self.hourlyTemperature = hourly.temp
    }
    
}
