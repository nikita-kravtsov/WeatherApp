//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита on 6/7/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
   
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let dayOfWeek: TimeInterval
    var dayOfWeekString: String {
        return String(dayOfWeek)
    }
    
    let dayTemp: Double
    var dayTempString: String {
        return String(format: "%.0f", dayTemp)
    }
    
    let nightTemp: Double
    var nightTempString: String {
        return String(format: "%.0f", nightTemp)
    }
    
    let weatherDescription: String
    

    init?(currentWeatherData: CurrentWheatherData) {
        cityName = currentWeatherData.timezone
        temperature = currentWeatherData.current.temp
        weatherDescription = currentWeatherData.current.weather[0].description
        dayOfWeek = currentWeatherData.daily[0].dt
        dayTemp = currentWeatherData.daily[0].temp.day
        nightTemp = currentWeatherData.daily[0].temp.night
    }
}
