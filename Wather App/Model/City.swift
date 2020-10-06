//
//  City.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

struct AllCities: Decodable{
    let cities = [City]()
}

struct City: Decodable {
    let name: String
    let id: Int
    let coord: Cordinate
}



struct Cordinate: Decodable {
    let lat: Float
    let lon: Float
}

struct CitySection {
    var letter: String
    var cities: [String]
}
