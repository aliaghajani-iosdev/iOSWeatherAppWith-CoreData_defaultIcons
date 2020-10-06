//
//  Weather.swift
//  weather
//
//  Created by Ali Aghajani on 10/3/20.
//

import Foundation


// MARK: - Welcome
struct WeatherModel: Decodable {
    let list: [List]
    let city: City
}

// MARK: - City
//struct City: Decodable {
//    let id: Int
//    let name: String
//    let coord: Coord
//    let country: String
//    let population, timezone, sunrise, sunset: Int
//}

// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double
//}

// MARK: - List
struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    
    let wind: Wind
    let visibility: Int
    
    let dt_txt: String

}

// MARK: - Clouds


// MARK: - Main
struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
    let temp_kf: Double

}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}


struct HourlyWeather: Decodable {
   let hour: String
   let icon: String
}

extension HourlyWeather {
    
    init(_ hour: String, _ icon: String) {
        self.hour = hour
        self.icon = icon
    }
}
