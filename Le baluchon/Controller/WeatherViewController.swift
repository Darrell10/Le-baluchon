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
    
    @IBOutlet weak var city1Label: UILabel!
    @IBOutlet weak var icon1Image: UIImageView!
    @IBOutlet weak var temp1Label: UILabel!
    @IBOutlet weak var desc1Label: UILabel!
    @IBOutlet weak var city1View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
        city1View.layer.cornerRadius = 10
        city1View.alpha = 0.9
        
    }
    
    private func updateWeather() {
        weatherService.getNYWeather { [unowned self] result in
            switch result {
                case .success(let cityData):
                    guard let city1 = cityData.message else { return }
                    DispatchQueue.main.async {
                        self.desc1Label.text = city1
                    }
                case .failure:
                    self.presentAlert(message: "Weather download Fail")
            }
        }
    }
}

