//
//  UIViewControllerExtension.swift
//  Le baluchon
//
//  Created by Frederick Port on 03/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String){
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
    }
}
