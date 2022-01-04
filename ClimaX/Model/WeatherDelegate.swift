//
//  WeatherDelegate.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 28/12/2021.
//

import Foundation


protocol WeatherDelegate {
    func didUpdateWeather(weatherList: [WeatherModel])
    func didFailWithError(error: Error)
}
