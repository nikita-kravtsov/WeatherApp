//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/8/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct DailyWeather {

    var networkWeatherManager = NetworkWeatherManager()
    
    
    let dailyWeekday: TimeInterval
    
    let dailyIcon: Int
    var dailyIconString: String {
        switch dailyIcon {
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
    
    let dailyHighTemp: Double
    var dailyHighTempString: String {
        return String(format: "%.0f", dailyHighTemp)
    }
    
    let dailyLowTemp: Double
    var dailyLowTempString: String {
        return String(format: "%.0f", dailyLowTemp)
    }
    
    init?(weatherData: WeatherData) {
    
        self.dailyWeekday = weatherData.current.dt
        self.dailyHighTemp = weatherData.daily[0].temp.max
        self.dailyLowTemp = weatherData.daily[0].temp.min
        self.dailyIcon = weatherData.current.weather.first!.id
    }
}

var dailyWeatherArray: [DailyWeather] = [] 

//var dailyWeatherArray: [DailyWeather] = []
