//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Nebula on 18.02.24.
//

import Foundation

struct weatherModel: Codable {
    var weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

struct Weather: Codable {
    var description: String
    var icon: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}


