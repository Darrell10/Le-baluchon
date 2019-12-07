//
//  LocalisationExtension.swift
//  Le baluchon
//
//  Created by Frederick Port on 03/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import Foundation
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    
    func setup() {
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        let coords = location.coordinate
        WeatherService().getUserWeather(coords.latitude, coords.longitude) { [unowned self] result in
            switch result {
            case .success(let userData):
                DispatchQueue.main.async {
                    guard let user = userData.list.first else { return }
                    self.currentTempLabel.text = "\(user.main.temp)°C"
                    self.currentCityLabel.text = user.name
                    self.currentIconImage.loadIcon(user.weather[0].icon)
                    self.currentDescLabel.text = user.weather[0].weatherDescription
                }
            case .failure:
                self.presentAlert(title: "Erreur", message: "Les données météo ont échouées")
                self.userCityView.isHidden = true
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur: \(error.localizedDescription)")
    }
    
}
