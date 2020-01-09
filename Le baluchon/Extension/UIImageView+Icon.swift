//
//  UIImageView+Icon.swift
//  Le baluchon
//
//  Created by Frederick Port on 03/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadIcon(_ icon: String) {
       let urlString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                guard d != nil else { return }
                let image = UIImage(data: d!)
                self.image = image
            }
        }.resume()
    }
}
