//
//  TranslateViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit
import AVFoundation

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.cornerRadius = 10
        textView.alpha = 0.9
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initiateTranslation()
    }
    
    private func initiateTranslation() {
        
        TranslateService.shared.translate(completion: { (translation) in
            if let translation = translation {
                DispatchQueue.main.async { [unowned self] in
                    self.textView.text = translation
                    self.speak()
                }
            } else {
                self.presentAlert(title: "Erreur", message: "La traduction à échouée")
                
            }
        })
        
    }
    
    private func speak() {
        if let texte = textView.text {
            let languageSpeak = TranslateService.shared.targetLanguageCode
            let speech = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: texte)
            utterance.rate = 0.5
            utterance.voice = AVSpeechSynthesisVoice(language: languageSpeak)
            speech.speak(utterance)
        }
        
    }
}
