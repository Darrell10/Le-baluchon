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
            <#code#>
        }
        // ajout de la requete API pour les coordonnées de l'appareil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur: \(error.localizedDescription)")
    }
    
}
