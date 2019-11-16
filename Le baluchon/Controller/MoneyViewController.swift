//
//  MoneyViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {
    
    let deviseService = DeviseService()

    override func viewDidLoad() {
        super.viewDidLoad()

        deviseService.getCurrency { (success, devise) in
                   //self.toggleActivityIndicator(shown: false)
                   if success, let devise = devise {
                       self.update(devise: devise)
                       
                   } else {
                       self.presentAlert()
                   }
               }
    }

    @IBAction func convertDeviseButton(_ sender: Any) {
       
    }
    
    private func update(devise: Devises) {
        print(devise.date)
       }
    
}

extension MoneyViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Devise download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
