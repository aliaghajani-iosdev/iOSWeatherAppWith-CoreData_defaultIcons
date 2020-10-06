//
//  CitiesQuickInfo.swift
//  weather
//
//  Created by Ali Aghajani on 10/3/20.
//

import Foundation

struct CitiesQuickInfo: Decodable {
    var cities: [CityQuickDetail]
    
}


struct CityQuickDetail : Decodable {
    let cityName: String
    let date: String
    let temp: Double
    let icon: String
}


extension CityQuickDetail {
    init(_ cityName: String, _ date: String, _ temp:Double, _ icon: String) {
        self.cityName = cityName
        self.date = date
        self.temp = temp
        self.icon = icon
    }
}
