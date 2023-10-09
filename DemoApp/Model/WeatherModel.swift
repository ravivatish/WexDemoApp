//
//  WeatherModel.swift
//  DemoApp
//
//  Created by ravinder kumar on 10/9/23.
//

import Foundation

struct WeatherModel: Codable  {
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let name: String
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let main, description, icon: String
}

