//
//  EditorViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    // MARK: - Property
    
    var translateService = TranslateService()
    
    @IBOutlet weak var editorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateService.delegateDisplay = self
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
            translateService.detectionLang(forText: self.editorTextView.text)
        }
    }
    
    @IBAction func translate(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Traduction du texte", message: "le texte est vide !")
        } else {
            translateService.textToTranslate = editorTextView.text
            performSegue(withIdentifier: "LanguagesViewControllerSegue", sender: self)
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
