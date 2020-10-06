//
//  AllCitiesViewModel.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

struct AllCitiesViewModel: Decodable{
    let cityViewModels: [CityViewModel]
    
}
extension AllCitiesViewModel {
    //
    
    func numberOfSection(citiesList: [String]) -> Int {
        var citiesWithLetters = [CitySection]()
        let groupeddictionary = Dictionary(grouping: citiesList, by: {String($0.prefix(1))})
        let keys = groupeddictionary.keys.sorted()
        citiesWithLetters = keys.map{CitySection(letter: $0, cities: groupeddictionary[$0]!.sorted())}
        return citiesWithLetters.count
    }
    
    
    
//    func groupingCitiesAlphabeticaly(citiesList: [String]) -> ([CitySection]) {
//        var citiesWithLetters = [CitySection]()
//        let groupeddictionary = Dictionary(grouping: citiesList, by: {String($0.prefix(1))})
//        let keys = groupeddictionary.keys.sorted()
//        citiesWithLetters = keys.map{CitySection(letter: $0, cities: groupeddictionary[$0]!.sorted())}
//        return citiesWithLetters
//    }
}






struct CityViewModel: Decodable {
    private let city: City
    let coord: Cordinate
    
    var name: String {
        return self.city.name
    }
    
    var cordinate: Cordinate {
        return self.city.coord
    }
    
}

extension CityViewModel {
    init(_ city: City, coord: Cordinate) {
        self.city = city
        self.coord = coord
    }
}




struct CordinateViewModel: Decodable {
    let lat: Float
    let lon: Float
}
