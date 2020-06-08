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
    
    
    let currentHightTemp: Double
    var currentHighTempString: String {
        return String(format: "%.0f", currentHightTemp)
    }
    
    let currentLowTemp: Double
    var currentLowTempString: String {
        return String(format: "%.0f", currentLowTemp)
    }
    
    let currentWeatherDescription: String
    

    init?(currentWeatherData: CurrentWheatherData) {
        currentCityName = currentWeatherData.timezone
        currentTemperature = currentWeatherData.current.temp
        currentWeatherDescription = currentWeatherData.current.weather[0].description
        currentWeekday = currentWeatherData.current.dt
        currentHightTemp = currentWeatherData.daily[0].temp.max
        currentLowTemp = currentWeatherData.daily[0].temp.min
    }
}
