//
//  ViewController.swift
//  ClimaX
//
//  Created by Hilario Cuervo on 24/12/2021.
//

import UIKit
import CoreLocation


class ClimaViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var rainProbabilityLabel: UILabel!
    @IBOutlet weak var futureClimatesCollectionView: UICollectionView!
    
    var weatherManager = WeatherManager()
    var futureClimates = [WeatherModel]()
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        weatherManager.delegate = self
        futureClimatesCollectionView.dataSource = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        futureClimatesCollectionView.register(UINib(nibName: "FutureClimateCell", bundle: nil), forCellWithReuseIdentifier: "ClimateCell")
    }

}


// MARK: - UITextFieldDelegate

extension ClimaViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if searchBar.text == "" {
            searchBar.placeholder = "Please, type some city"
            return false
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityName = searchBar.text {
            weatherManager.searchWeather(city: cityName)
        }
        
        searchBar.text = ""
    }
    
}


// MARK: - WeatherDelegate

extension ClimaViewController: WeatherDelegate {
    
    func didUpdateWeather(weatherList: [WeatherModel]) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weatherList[0].cityName
            self.weatherImage.image = UIImage(systemName: weatherList[0].weatherImageName)
            self.temperatureLabel.text = weatherList[0].temperatureString
            self.windSpeedLabel.text = weatherList[0].windSpeedString
            self.rainProbabilityLabel.text = weatherList[0].rainProbabilityString
            
            self.futureClimates = Array(weatherList.dropFirst())
            self.futureClimatesCollectionView.reloadData()
        }
    }
    
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Error trying to find the weather for the city", message: "Please, check that the city name is valid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


// MARK: - UICollectionViewDataSource

extension ClimaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return futureClimates.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = futureClimatesCollectionView.dequeueReusableCell(withReuseIdentifier: "ClimateCell", for: indexPath) as? FutureClimateCell
        
        cell?.hourLabel.text = futureClimates[indexPath.row].hour
        cell?.weatherImage.image = UIImage(systemName: futureClimates[indexPath.row].weatherImageName)
        cell?.temperatureLabel.text = futureClimates[indexPath.row].temperatureString
        
        return cell!
    }
    
}


// MARK: - CLLocationManagerDelegate

extension ClimaViewController: CLLocationManagerDelegate {
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.searchWeather(latitude: lat, longitude: lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error with the current location weather", message: "Please, check to have the app location permissions activated", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
