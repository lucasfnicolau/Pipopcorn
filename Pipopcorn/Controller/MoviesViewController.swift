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

    func setTextField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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

    @IBAction func searchButtonTouched(_ sender: UIButton) {
        guard let text = nameTextField.text,
            text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
        nameTextField.resignFirstResponder()
        
        // ...
    }
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension MoviesViewController: UITableViewDelegate { }

extension MoviesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTouched(UIButton())
        return false
    }

}
