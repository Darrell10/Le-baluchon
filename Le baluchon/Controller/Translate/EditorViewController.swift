//
//  EditorViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    @IBOutlet weak var editorTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func detectLanguage(_ sender: Any) {
        if editorTextView.text == "" {
            //present an alert if text view is empty
            self.presentAlert(title: "Detection de la langue", message: "le texte est vide !")
        } else {
            TranslateService.shared.detectLanguage(forText: self.editorTextView.text!) { (language) in
                if let language = language {
                    DispatchQueue.main.async {
                        // Present an alert with the detected language.
                        self.presentAlert(title: "Detection de la langue", message: "Le langage suivant a été détecté:\n\n\(language)")
                    }
                } else {
                    // Present an alert saying that an error occurred.
                    self.presentAlert(title: "Detection de la langue", message: "Oops! le language n'a pas été détecté.")
                }
            }
            
        }
        
    }
    
    
    @IBAction func translate(_ sender: Any) {
        if editorTextView.text != "" {
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
