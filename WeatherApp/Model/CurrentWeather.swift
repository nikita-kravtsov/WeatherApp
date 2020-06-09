//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/7/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let currentCityName: String
    
    let currentTemperature: Double
    var currentTemperatureString: String {
        return String(format: "%.0f", currentTemperature)
    }
    
    let currentWeekday: TimeInterval
    var currentWeekdayString: String {
        let unixDate: TimeInterval = currentWeekday
        let usableDate = Date(timeIntervalSince1970: unixDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: usableDate)
    }
    
    
    let currentHightTemp: Double
    var currentHighTempString: String {
        return String(format: "%.0f", currentHightTemp)
    }
    
    let currentLowTemp: Double
    var currentLowTempString: String {
        return String(format: "%.0f", currentLowTemp)
    }
    
    let currentWeatherDescription: String
    
    
    init?(weatherData: WeatherData) {
        currentCityName = weatherData.timezone
        currentTemperature = weatherData.current.temp
        currentWeatherDescription = weatherData.current.weather[0].description
        currentWeekday = weatherData.current.dt
        currentHightTemp = weatherData.daily[0].temp.max
        currentLowTemp = weatherData.daily[0].temp.min
    }
    
}
