//
//  weatherModel.swift
//  dripDrop_iOS22
//
//  Created by Ivan Ramirez on 10/18/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var currently: CurrentWeather
    var weeklyWeatherData: WeeklyWeather
    
    // NOTE: - when ever you hava an emum you need to use all your variables
   private enum CodingKeys: String, CodingKey {
        
        case weeklyWeatherData = "daily"
        case currently
    }
}


struct CurrentWeather: Codable {
    var time: TimeInterval
    var summary: String
    var temperature: Double
    var icon: String
}


struct WeeklyWeather: Codable {
    
    var summary: String
    var icon: String
    // NOTE: -  its going to be an array of the daily weather
    var data: [DailyWeather]
}

struct DailyWeather: Codable {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperatureMax: Double
    var temperatureMin: Double
}
