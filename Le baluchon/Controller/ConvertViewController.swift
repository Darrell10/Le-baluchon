//
//  MoneyViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 01/11/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var convertResult: UILabel!

    let deviseService = DeviseService()
    private var rate: Double = 1.10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func convertDeviseButton(_ sender: Any) {
        launchConvert()
    }
}

extension ConvertViewController : UITextFieldDelegate{
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dataTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ConvertViewController {
    private func launchConvert() {
        guard let amount = dataTextField.text else { return }
        checkInputValidity(input: amount)
    }
    
    private func checkInputValidity(input: String) {
        if let number = Double(input.replacingOccurrences(of: ",", with: ".")) {
            requestConversion(for: number)
        } else {
            convertResult.text = ""
        }
    }
    
    private func requestConversion(for amount: Double) {
        deviseService.getCurrency { (res) in
            switch res {
            case .success:
                self.updateDisplay(with: amount, and: self.rate)
            case . failure:
                self.presentAlert()
            }
        }
    }
    
    private func updateDisplay(with amount: Double, and rate: Double) {
        convertResult.text = Devises.convert(amount, with: rate)
    }
}

extension ConvertViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Devise download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
