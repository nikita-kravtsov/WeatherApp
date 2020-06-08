//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/8/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct DailyWeather {
    let dailyWeekday: TimeInterval
    let dailyIcon: String
    
    let dailyHighTemp: Double
    var dailyHighTempString: String {
        return String(format: "%.0f", dailyHighTemp)
    }
    
    let dailyLowTemp: Double
    var dailyLowTempString: String {
        return String(format: "%.0f", dailyLowTemp)
    }
    
    
    init?(currentWeatherData: CurrentWheatherData) {
        
        dailyWeekday = currentWeatherData.current.dt
        dailyHighTemp = currentWeatherData.daily[0].temp.max
        dailyLowTemp = currentWeatherData.daily[0].temp.min
        dailyIcon = currentWeatherData.current.weather[0].icon
        
    }
}
