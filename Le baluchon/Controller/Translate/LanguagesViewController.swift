//
//  LanguagesViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {
    
    //let translateService = TranslateService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        supportedLang()
    }
    
    func supportedLang() {
        var urlParams = [String: String]()
        urlParams["key"] = TranslateService.shared.apiKey
        urlParams["target"] = Locale.current.languageCode ?? "en"
        TranslateService.shared.getLanguageList(usingTranslationAPI: .supportedLanguages, urlParams: urlParams) { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for name in results.data.languages {
                        let languageName = name.name
                        let languageCode = name.language
                        TranslateService.shared.supportedLanguages.append(TranslationLanguage(code: languageCode, name: languageName))
                    }
                    self.tableView.reloadData()
                case .failure:
                        self.presentAlert(title: "Erreur", message: "aucune langue disponible")
                }
            }
        }
    }
}

extension LanguagesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TranslateService.shared.supportedLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        let language = TranslateService.shared.supportedLanguages[indexPath.row]
        cell.textLabel?.text = language.name
        cell.detailTextLabel?.text = language.code
        return cell
    }
}

extension LanguagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        TranslateService.shared.targetLanguageCode = TranslateService.shared.supportedLanguages[indexPath.row].code
        performSegue(withIdentifier: "TranslationViewControllerSegue", sender: self)
    }
}
