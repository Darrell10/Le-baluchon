//
//  LanguagesViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

final class LanguagesViewController: UIViewController {
    
    // MARK: - Property
    
    private var translateService = TranslateService()
    private var supportedLanguages = [TranslationLanguage]()
    var delegate: LanguageDelegate?

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        supportedLang()
    }
    
    /// Get the list of avaliable languages
    func supportedLang() {
        translateService.getLanguageList() { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for name in results.data.languages {
                        let languageName = name.name
                        let languageCode = name.language
                        self.supportedLanguages.append(TranslationLanguage(code: languageCode, name: languageName))
                    }
                    self.tableView.reloadData()
                case .failure:
                    self.presentAlert(title: "Erreur", message: "aucune langue disponible")
                }
            }
        }
    }
}

// MARK: - TableView Property

extension LanguagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportedLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        let language = supportedLanguages[indexPath.row]
        cell.textLabel?.text = language.name
        cell.detailTextLabel?.text = language.code
        return cell
    }
}

extension LanguagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        delegate?.passLanguageBack(supportedLanguages[indexPath.row].code)
        dismiss(animated: true, completion: nil)
    }
}
