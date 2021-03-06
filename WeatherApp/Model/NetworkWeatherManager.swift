//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Никита on 6/7/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    var onCompletionWithCurrentWeather: ((CurrentWeather) -> Void)?
    var onCompletionWithDailyWeather: (([DailyWeather]) -> Void)?
    var onCompletionWithHourlyWeather: (([HourlyWeather]) -> Void)?
    
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&lang=ru"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            guard let currentWeather = self.parseJSON(withCurrentWeatherData: data) else { return }
            guard let dailyWeather = self.parseJSON(withDailyWeatherData: data) else { return }
            guard let hourlyWeather = self.parseJSON(withHourlyWeatherData: data) else { return }
            self.onCompletionWithCurrentWeather?(currentWeather)
            self.onCompletionWithDailyWeather?(dailyWeather)
            self.onCompletionWithHourlyWeather?(hourlyWeather)
        }
        task.resume()
    }
    
    func parseJSON(withCurrentWeatherData data: Data) -> CurrentWeather? {
        
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData) else { return nil }
            return currentWeather
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parseJSON(withDailyWeatherData data: Data) -> [DailyWeather]? {
        
        var dailyWeatherData: [DailyWeather] = []
        
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            
            for day in weatherData.daily {
                guard let dailyWeather = DailyWeather(dailyDay: day) else { return nil }
                dailyWeatherData.append(dailyWeather)
            }
            return dailyWeatherData
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parseJSON(withHourlyWeatherData data: Data) -> [HourlyWeather]? {

         var hourlyWeatherData: [HourlyWeather] = []

         do {
             let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)

            for hour in weatherData.hourly {
                 guard let hourlyWeather = HourlyWeather(hourly: hour) else { return nil }
                 hourlyWeatherData.append(hourlyWeather)
             }
             return hourlyWeatherData

         } catch {
             print(error.localizedDescription)
         }
         return nil
     }
}

