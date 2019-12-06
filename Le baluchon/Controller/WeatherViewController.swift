//
//  MeteoViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    private let weatherService = WeatherService()
    
    var manager = CLLocationManager()
    
    // New York City View
    @IBOutlet weak var city1Label: UILabel!
    @IBOutlet weak var icon1Image: UIImageView!
    @IBOutlet weak var desc1Label: UILabel!
    @IBOutlet weak var city1View: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // User City View
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentDescLabel: UILabel!
    @IBOutlet weak var currentIconImage: UIImageView!
    @IBOutlet weak var userCityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNYWeather()
        setup()
        city1View.layer.cornerRadius = 10
        city1View.alpha = 0.9
        userCityView.layer.cornerRadius = 10
        userCityView.alpha = 0.9
    }
    
    private func updateNYWeather() {
        weatherService.getNYWeather { [unowned self] result in
            switch result {
            case .success(let cityData):
                DispatchQueue.main.async {
                    guard let first = cityData.list.first else { return }
                    self.tempLabel.text = "\(first.main.temp)°C"
                    self.city1Label.text = first.name
                    self.icon1Image.loadIcon(first.weather[0].icon)
                    self.desc1Label.text = first.weather[0].weatherDescription
                }
            case .failure:
                self.presentAlert(message: "Weather download fail")
                self.city1View.isHidden = true
            }
        }
    }
    
    private func updateUserWeather() {
        
        
    }
}

