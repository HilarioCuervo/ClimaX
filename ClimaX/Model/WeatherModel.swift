//
//  WeatherModel.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 28/12/2021.
//

import Foundation


struct WeatherModel {
    
    let cityName: String
    let weatherId: Int
    let temperature: Double
    let windSpeed: Double // Recordar pasar a km/h
    let rainProbability: Double
    let dateTime: String
    
    
    var weatherImageName: String {
        switch weatherId {
        
        case 200...232:
            return "cloud.bolt"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
            
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
        }
    }
    
    
    var temperatureString: String {
        let auxString = String(format: "%.1f", temperature)
        return auxString + "°"
    }
    
    
    var windSpeedString: String {
        let auxString = String(format: "%.1f", windSpeed)
        return auxString + " km/h"
    }
    
    
    var rainProbabilityString: String {
        let auxString = String(format: "%.1f", rainProbability)
        return auxString + " %"
    }
    
    
    var hour: String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        if let date = dateFormatterGet.date(from: dateTime) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
    
}
