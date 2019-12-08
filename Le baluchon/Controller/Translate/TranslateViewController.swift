//
//  TranslateViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initiateTranslation()
    }
    
    func initiateTranslation() {
        
        TranslateService.shared.translate(completion: { (translation) in
            if let translation = translation {
                DispatchQueue.main.async { [unowned self] in
                    self.textView.text = translation
                }
            } else {
                self.presentAlert(title: "Erreur", message: "La traduction à échouée")
                
            }
        })
        
    }
}
