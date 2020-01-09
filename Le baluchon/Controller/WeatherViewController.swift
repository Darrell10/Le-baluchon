//
//  MeteoViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    // MARK: - Property
    
    private let weatherService = WeatherService()
    var manager = CLLocationManager()
    
    // New York City View
    @IBOutlet weak var city1Label: UILabel!
    @IBOutlet weak var icon1Image: UIImageView!
    @IBOutlet weak var desc1Label: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // User City View
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentDescLabel: UILabel!
    @IBOutlet weak var currentIconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNYWeather()
        updateUserWeather()
    }
    
    // MARK: - Update Weather function
    
    private func updateNYWeather() {
        weatherService.getWeather(lat: "40.7306", lon: "-73.9867") { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cityData):
                    guard let first = cityData.list.first else { return }
                    self.tempLabel.text = "\(first.main.temp)°C"
                    self.city1Label.text = first.name
                    self.icon1Image.loadIcon(first.weather[0].icon)
                    self.desc1Label.text = first.weather[0].weatherDescription
                case .failure:
                    self.presentAlert(title: "Erreur", message: "Les données météo ont échouées")
                }
            }
        }
    }
    
}

    // MARK: - Update Weather user location function

extension WeatherViewController: CLLocationManagerDelegate {
    
    /// Get the user's position and update the weather
    func updateUserWeather() {
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        let coords = location.coordinate
        let userlat = "\(coords.latitude)"
        let userLon = "\(coords.longitude)"
        weatherService.getWeather(lat: userlat, lon: userLon) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    guard let user = userData.list.first else { return }
                    self.currentTempLabel.text = "\(user.main.temp)°C"
                    self.currentCityLabel.text = user.name
                    self.currentIconImage.loadIcon(user.weather[0].icon)
                    self.currentDescLabel.text = user.weather[0].weatherDescription
                case .failure:
                    self.presentAlert(title: "Erreur", message: "Les données météo ont échouées")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur: \(error.localizedDescription)")
    }
    
}


