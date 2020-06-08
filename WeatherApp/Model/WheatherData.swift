 //
//  CurrentWheatherData.swift
//  WeatherApp
//
//  Created by Никита on 6/7/20.
//  Copyright © 2020 Никита. All rights reserved.
//

 import Foundation
 
 struct WeatherData: Codable {
    
    let timezone: String
    let current: Current
    let daily: [Daily]
 }
 
 struct Current: Codable {
    let dt: TimeInterval
    let temp: Double
    let weather: [Weather]
    
 }
  
 struct Daily: Codable {
    let dt: TimeInterval
    let temp: Temp
    let weather: [Weather]
 }
 
 struct Temp: Codable {
    let min: Double
    let max: Double
 }
 
 struct Weather: Codable {
    let description: String
    let icon: String
 }
 
 
 
 
 
 

 

 
 
 
//     let name: String
// //    let weather: [Weather]
// //    let main: Main
// // }
// //
// // struct Weather: Codable {
// //    let description: String
// // }
// //
// // struct Main: Codable {
// //    let temp: Double
// //    let tempMin: Double
// //    let tempMax: Double
// //
// //    enum CodingKeys: String, CodingKey {
// //        case temp
// //        case tempMin = "temp_min"
// //        case tempMax = "temp_max"
// //    }
