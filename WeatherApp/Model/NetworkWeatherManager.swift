//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Никита on 6/7/20.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather() {
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=53.907278&lon=27.554915&appid=\(apiKey)&units=metric&lang=ru"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let currentWeather = self.parseJSON(withData: data) else { return }
            self.onCompletion?(currentWeather)
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData) else { return nil }
            return currentWeather
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

