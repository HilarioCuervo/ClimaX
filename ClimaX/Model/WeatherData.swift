//
//  WeatherData.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 28/12/2021.
//

import Foundation


struct WeatherData: Decodable {
    var list: [List]
    let city: City
}


struct City: Decodable {
    let name: String
}


struct List: Decodable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let pop: Double
    let dt_txt: String
}


struct Wind: Decodable {
    let speed: Double
}


struct Weather: Decodable {
    let id: Int
    let main: String
}


struct Main: Decodable {
    let temp: Double
}
