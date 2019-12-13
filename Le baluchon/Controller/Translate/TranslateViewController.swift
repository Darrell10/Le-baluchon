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
    
    // MARK: - Property
    
    @IBOutlet weak var textView: UITextView!
    
    var translateService = TranslateService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initiateTranslation()
    }
    
    // MARK: - Translate function's
    
    private func initiateTranslation() {
        guard let textToTranslate = translateService.textToTranslate else { return }
        guard let targetLanguage = translateService.targetLanguageCode else { return }
        var urlParams = [String: String]()
        urlParams["key"] = translateService.apiKey
        urlParams["q"] = textToTranslate
        urlParams["target"] = targetLanguage
        urlParams["format"] = "text"
        if let sourceLanguage = translateService.sourceLanguageCode {
            urlParams["source"] = sourceLanguage
        }
        translateService.getTranslation(usingTranslationAPI: .translate, urlParams: urlParams) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translate):
                    for text in translate.data.translations {
                        self.textView.text = text.translatedText
                        self.speak()
                    }
                case .failure:
                    self.presentAlert(title: "Erreur", message: "Les données ont échouées")
                }
            }
        }
    }
    
    /// Function that has played voice translation
    private func speak() {
        if let texte = textView.text {
            let languageSpeak = translateService.targetLanguageCode
            let speech = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: texte)
            utterance.rate = 0.5
            utterance.voice = AVSpeechSynthesisVoice(language: languageSpeak)
            speech.speak(utterance)
        }
        
    }
}
