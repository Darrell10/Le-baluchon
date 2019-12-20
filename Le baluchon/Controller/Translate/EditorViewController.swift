//
//  EditorViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit
import AVFoundation

class EditorViewController: UIViewController {
    
    // MARK: - Property
    
    var translateService = TranslateService()
    
    @IBOutlet weak var editorTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Transfer of data to the LanguagesViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LanguagesViewControllerSegue" {
            let successVC = segue.destination as! LanguagesViewController
            successVC.translateService = translateService
        }
    }
    
    // MARK: - Navigations Buttons
    
    @IBAction func detectLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Detection de la langue", message: "le texte est vide !")
        } else {
            detectionLang()
        }
    }
    
    @IBAction func getLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Traduction du texte", message: "le texte est vide !")
        } else {
            performSegue(withIdentifier: "LanguagesViewControllerSegue", sender: self)
        }
    }
    
    // MARK: - Translate Button action
    
    @IBAction private func translateLanguage(_ sender: Any) {
            initiateTranslation()
    }
    
    private func initiateTranslation() {
        guard let textToTranslate = editorTextView.text else { return }
        translateService.getTranslation(text: textToTranslate) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translate):
                    for text in translate.data.translations {
                        self.translateTextView.text = text.translatedText
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
        if let text = translateTextView.text {
            let languageSpeak = translateService.targetLanguageCode
            let speech = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = 0.5
            utterance.voice = AVSpeechSynthesisVoice(language: languageSpeak)
            speech.speak(utterance)
        }
    }
    
    /// Function that detected the language of the editorText
    func detectionLang() {
        guard let detectLang = editorTextView.text else { return }
        translateService.getDetectionLang(text: detectLang) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    print(results)
                    guard let data = results.data.detections.first else { return }
                    guard let language = data.first?.language else { return }
                    self.presentAlert(title: "Detection de la langue", message: "Le langage suivant a été détecté:\n\n\(language)")
                case .failure:
                    self.presentAlert(title: "Detection de la langue", message: "Oops! le language n'a pas été détecté.")
                }
            }
        }
    }
    
}

// MARK: - Dismiss keyboard

extension EditorViewController : UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editorTextView.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
