//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/8/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class DailyWeather: NetworkWeatherManager {

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
    
    
    init?(weatherData: WeatherData) {
        
        dailyWeekday = weatherData.current.dt
        dailyHighTemp = weatherData.daily[0].temp.max
        dailyLowTemp = weatherData.daily[0].temp.min
        dailyIcon = weatherData.current.weather[0].icon
    }
}
//    init?(currentWeatherData: CurrentWheatherData) {
//        
//        dailyWeekday = currentWeatherData.current.dt
//        dailyHighTemp = currentWeatherData.daily[0].temp.max
//        dailyLowTemp = currentWeatherData.daily[0].temp.min
//        dailyIcon = currentWeatherData.current.weather[0].icon
//        
//    }

//    var dailyWeatherArray: [DailyWeather] = []
