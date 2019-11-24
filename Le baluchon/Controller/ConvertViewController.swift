//
//  MoneyViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {
    
// MARK: - Property
    
    private var updateRate: Double = 1.00
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var convertResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Convert Action Button

extension ConvertViewController {
    @IBAction func convertDeviseButton(_ sender: Any) {
        convertDevise()
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

// MARK: - Convert Display to Double

extension ConvertViewController {
    private func convertDevise() {
        guard let amount = dataTextField.text else { return }
        convertDataToDouble(input: amount)
    }
    
    private func convertDataToDouble(input: String) {
        if let number = Double(input.replacingOccurrences(of: ",", with: ".")) {
            requestConversion(for: number)
        } else {
            convertResult.text = ""
        }
    }
    
    private func requestConversion(for amount: Double) {
        DeviseService.shared.getCurrency { (result) in
            switch result {
            case .success(let ratesData):
                self.updateRate = ratesData.rates["USD"] ?? 0.00
                self.updateDisplay(with: amount, and: self.updateRate)
            case .failure:
                self.presentAlert()
            }
        }
    }
    
    private func updateDisplay(with amount: Double, and rates: Double) {
        convertResult.text = ( " \(Devises.convert(value: amount, with: updateRate)) $")
    }
}

// MARK: - Alert controller

extension ConvertViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Devise download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
