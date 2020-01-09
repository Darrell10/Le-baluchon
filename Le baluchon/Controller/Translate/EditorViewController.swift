//
//  EditorViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit
import AVFoundation

final class EditorViewController: UIViewController {
    
    // MARK: - Property
    
    private let translateService = TranslateService()
    private var codeLanguage = "en"
    
    @IBOutlet weak var editorTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

    // MARK: - Navigations Buttons

extension EditorViewController: LanguageDelegate {
    // Detect Language
    @IBAction func detectLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Detect Language", message: "Text is empty")
        } else {
            detectionLang()
        }
    }
    
    /// Function that detected the language of the editorText
    func detectionLang() {
        guard let detectLang = editorTextView.text else { return }
        translateService.getDetectionLang(text: detectLang) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    guard let data = results.data.detections.first else { return }
                    guard let language = data.first?.language else { return }
                    self.presentAlert(title: "Detect Language", message: "Language detected is:\n\n\(language)")
                case .failure:
                    self.presentAlert(title: "Detect Language", message: "Oops! language was not deteted.")
                }
            }
        }
    }
    
    // Get Language List
    
    @IBAction func getLanguageListBtn(_ sender: Any) {
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue", let second = segue.destination as? LanguagesViewController {
            second.delegate = self
        }
    }
    
    func passLanguageBack(_ languageCode: String) {
        codeLanguage = languageCode
    }
}

    // MARK: - Translate Button action

extension EditorViewController {
    @IBAction private func translateLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Translation", message: "text is empty! ")
        } else {
            initiateTranslation()
        }
    }
    
    private func initiateTranslation() {
        guard let textToTranslate = editorTextView.text else { return }
        translateService.getTranslation(text: textToTranslate, code: codeLanguage) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translate):
                    for text in translate.data.translations {
                        self.translateTextView.text = text.translatedText
                        self.speak()
                    }
                case .failure:
                    self.presentAlert(title: "Error", message: "Data failed")
                }
            }
        }
    }
    
    /// Function that has played voice translation
    private func speak() {
        if let text = translateTextView.text {
            let languageSpeak = codeLanguage
            let speech = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = 0.5
            utterance.voice = AVSpeechSynthesisVoice(language: languageSpeak)
            speech.speak(utterance)
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
