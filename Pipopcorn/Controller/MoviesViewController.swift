//
//  MoviesViewController.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 25/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setTableView()
    }

    @IBAction func searchButtonTouched(_ sender: UIButton) {
        dismissKeyboard()
        guard let text = nameTextField.text,
            text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
        
        // ...
    }

    func setTextField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        self.nameTextField.delegate = self
    }

    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    @objc func dismissKeyboard() {
        nameTextField.resignFirstResponder()
    }
    
    @IBAction func infoButtonTouched(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "OMDb API", message: "Todos os dados utilizados neste app foram consumidos utilizando a OMDb API", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        let openLicense = UIAlertAction(title: "Licença da API", style: .default) { _ in
            if let url = URL(string: "https://www.omdbapi.com/legal.htm") {
                UIApplication.shared.open(url)
            }
        }

        alertController.addAction(cancel)
        alertController.addAction(openLicense)

        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
