//
//  LanguagesViewController.swift
//  Le baluchon
//
//  Created by Frederick Port on 06/12/2019.
//  Copyright © 2019 Frederick Port. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TranslateService.shared.fetchSupportedLanguages(completion: { (success) in
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        })
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
