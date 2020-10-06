//
//  WeeklyInfo.swift
//  weather
//
//  Created by Ali Aghajani on 10/4/20.
//

import Foundation

struct WeeklyInfo : Decodable {
    let dayName: String
    let maxTemp: Double
    let minTemp: Double
    let icon: String
}


extension WeeklyInfo {
    init(_ dayName: String, _ maxTemp: Double, _ minTemp:Double, _ icon: String) {
        self.dayName = dayName
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.icon = icon
    }
}
