//
//  EditorViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    //let translateService = TranslateService()
    
    @IBOutlet weak var editorTextView: UITextView!
    
    func detectionLang(forText text: String) {
        let urlParams = ["key": TranslateService.shared.apiKey, "q": text]
        TranslateService.shared.getDetectionLang(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    guard let data = results.data.detections.first else { return }
                    guard let language = data.first?.language else { return }
                    self.presentAlert(title: "Detection de la langue", message: "Le langage suivant a été détecté:\n\n\(language)")
                    
                case .failure:
                        self.presentAlert(title: "Detection de la langue", message: "Oops! le language n'a pas été détecté.")
                }
            }
        }
    }
    
    
    @IBAction func detectLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Detection de la langue", message: "le texte est vide !")
        } else {
            detectionLang(forText: self.editorTextView.text)
        }
        
    }
    
    @IBAction func translate(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Traduction du texte", message: "le texte est vide !")
        } else {
            TranslateService.shared.textToTranslate = editorTextView.text
            performSegue(withIdentifier: "LanguagesViewControllerSegue", sender: self)
        }
    }
    
}

extension EditorViewController : UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        editorTextView.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
