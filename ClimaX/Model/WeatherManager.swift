//
//  ClimaManager.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 27/12/2021.
//

import Foundation
import CoreLocation


struct WeatherManager {
    
    let weatherURL = "http://api.openweathermap.org/data/2.5/forecast?appid="
    var delegate: WeatherDelegate?
    

    func searchWeather(city: String) {
        let urlString = self.weatherURL + ApiKey.key + "&q=\(city)&units=metric"
        
        performRequest(urlString: urlString)
    }
    
    
    func searchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = self.weatherURL + ApiKey.key + "&lat=\(latitude)" + "&lon=\(longitude)&units=metric"
        
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let resultData = data {
                    if let resultWeatherList = subtractJson(data: resultData) {
                        delegate?.didUpdateWeather(weatherList: resultWeatherList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    func subtractJson(data: Data) -> [WeatherModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)

            let weatherStructure = createWeatherStructure(data: decodedData)
            return weatherStructure
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    func createWeatherStructure(data: WeatherData) -> [WeatherModel] {
        var resultStructure = [WeatherModel]()
        let cityName = data.city.name
        
        for i in 0...7 {
            
            let weatherId = data.list[i].weather[0].id
            let temperature = data.list[i].main.temp
            let windSpeed = data.list[i].wind.speed
            let rainProbability = data.list[i].pop
            let dateTime = data.list[i].dt_txt
            
            let oneWeather = WeatherModel(cityName: cityName, weatherId: weatherId, temperature: temperature, windSpeed: windSpeed, rainProbability: rainProbability, dateTime: dateTime)
            
            resultStructure.append(oneWeather)
        }
        
        return resultStructure
    }
    
}
