//
//  Webservice.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}



final class Webservice {
    let API_KEY: String = "ec36fc33a9951832c1e77a6484b212cb"
    let API_KEY_TWO: String = "2bcd03111a17f8d53b034b4b73d383c8"
    let API_KEY_Three: String = "18495a7ed4085562d60827d90ebe82cc"
  
    
    func loadCities(url:URL, completion: @escaping ([City]?) ->()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                DispatchQueue.main.async {
                    let cities =  try? JSONDecoder().decode([City].self, from: data)
                      if let cities = cities {
                          completion(cities)
                      }
                }
            }
        }.resume()
    }
    
    
    
    
    func getCityName(cityID: Int, compelition: @escaping ([String]?) ->()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?&lang=tr&appid=\(API_KEY_Three)&id=\(cityID)&units=metric")!
        URLSession.shared.dataTask(with: url) { data, respone, error in
            if let error = error {
                print(error.localizedDescription)
                compelition(nil)
            } else if let data = data {
                DispatchQueue.main.async {
                    let cityList = try? JSONDecoder().decode([String].self, from: data)
                    if let cityList = cityList {
                        compelition(cityList)
                    }
                }
            }
        }
    }
    
    
    
    func loadWeatherInformation(cityID: Int, compelition: @escaping (WeatherModel?) ->()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?&lang=tr&appid=\(API_KEY_TWO)&id=\(cityID)&units=metric")!
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print(error.localizedDescription)
                compelition(nil)
            } else if let data = data {
                DispatchQueue.main.async {
                    let weatherData = try? JSONDecoder().decode(WeatherModel.self, from: data)
                    if let weatherdata = weatherData {
                        compelition(weatherdata)
//                        print(weatherdata)
                    }
                }
            }
        }.resume()
    }
    
    
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> () ) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
