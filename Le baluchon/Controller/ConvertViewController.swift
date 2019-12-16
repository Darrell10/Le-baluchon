//
//  MoneyViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

final class ConvertViewController: UIViewController {
    
    // MARK: - Property
    
    private let deviseService = DeviseService()
    
    @IBOutlet private weak var dataTextField: UITextField!
    @IBOutlet private weak var convertResultLabel: UILabel!
    
    // MARK: - Convert Action Button
    
    @IBAction func convertDeviseButton(_ sender: Any) {
        convertDevise()
    }
    
    private func convertDevise() {
        guard let amount = dataTextField.text, let number = Double(amount) else { return }
        var urlParams = [String: String]()
        urlParams["access_key"] = valueForAPIKey(named:"API_FIXER_CLIENT_ID")
        urlParams["symbols"] = "USD"
        deviseService.getCurrency(usingTranslationAPI: .currency, urlParams: urlParams) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ratesData):
                    guard let rate = ratesData.rates["USD"] else { return }
                    self.convertResultLabel.text = ( " \(Devises.convert(value: number, with: rate)) $")
                case .failure:
                    self.presentAlert(title: "Erreur", message: "La conversion de devise à échouée")
                }
            }
        }
    }
    
}

// MARK: - Dismiss Keyboard

extension ConvertViewController : UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dataTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
