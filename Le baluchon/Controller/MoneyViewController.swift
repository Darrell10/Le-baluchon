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
        deviseService.getCurrency { (res) in
            switch res {
            case .success:
                print("Sa marche")
            case . failure:
                self.presentAlert()
            }
        }
    }

    @IBAction func convertDeviseButton(_ sender: Any) {
        
    }
    
}

extension MoneyViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Devise download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
