//
//  MeteoViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var city1Label: UILabel!
    @IBOutlet weak var desc1Label: UILabel!
    @IBOutlet weak var temp1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func updateWeatherButton(_ sender: Any) {
        /*WeatherService.shared.getNewYorkWeather { (success, weather) in
            //self.toggleActivityIndicator(shown: false)
            if success, let weather = weather {
                self.update(weather: weather)
            } else {
                self.presentAlert()
            }
        }*/
        
    }
    
    private func update(weather: WeatherApi) {
        city1Label.text = weather.name
        //desc1Label.text = weather.weather[2]
        //imageView.image = UIImage(data: quote.imageData)
    }
    
}

extension WeatherViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Weather download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
