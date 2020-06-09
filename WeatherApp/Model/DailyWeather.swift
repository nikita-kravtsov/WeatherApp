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
    var dailyWeekdayString: String {
        
        let unixDate: TimeInterval = dailyWeekday
        let usableDate = Date(timeIntervalSince1970: unixDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: usableDate)
    }
    
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
    
    init?(dailyDay: Daily) {
    
        self.dailyWeekday = dailyDay.dt
        self.dailyHighTemp = dailyDay.temp.max
        self.dailyLowTemp = dailyDay.temp.min
        self.dailyIcon = dailyDay.weather.first!.id
    }
}

 

//var dailyWeatherArray: [DailyWeather] = []


//let dailyIcon: Int
//   var dailyIconString: String {
//       switch dailyIcon {
//       case 200...232: return "cloud.bolt.rain.fill"
//       case 300...321: return "cloud.drizzle.fill"
//       case 500...531: return "cloud.rain.fill"
//       case 600...622: return "cloud.snow.fill"
//       case 701...781: return "cloud.fog.fill"
//       case 800: return "sun.max.fill"
//       case 801...804: return "cloud.fill"
//       default: return "nosign"
//       }
//   }
