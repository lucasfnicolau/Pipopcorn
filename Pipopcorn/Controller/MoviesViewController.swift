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

    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        setTableView()
    }

    @IBAction func searchButtonTouched(_ sender: UIButton) {
        dismissKeyboard()
        guard let text = nameTextField.text,
            text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }

        let name = text.trimmingCharacters(in: .whitespacesAndNewlines)

        movies = []
        self.tableView.reloadData()
        searchMovies(named: name)
    }

    func formatToQueryString(_ string: String) -> String {
        return string.components(separatedBy: " ").joined(separator: "%20")
    }

    func searchMovies(named name: String) {
        let queryStr = formatToQueryString(name)
        let fullURL = "\(ENDPOINT)=\(API_KEY)&s=\(queryStr)&type=movie"

        DispatchQueue.main.async {
            guard let url = URL(string: fullURL),
                let data = try? Data(contentsOf: url) else { return }

            if let search = try? JSONDecoder().decode(Search.self, from: data) {
                self.movies = search.movies
                self.tableView.reloadData()
            } else {
                print("Algo deu errado :(")
            }
        }
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
        self.tableView.reloadData()
        self.tableView.allowsSelection = true
    }

    @objc func dismissKeyboard() {
        nameTextField.resignFirstResponder()
    }

    @IBAction func infoButtonTouched(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: Alert.TITLE, message: Alert.MESSAGE, preferredStyle: .alert)
        let cancel = UIAlertAction(title: Alert.CANCEL_ACTION, style: .cancel, handler: nil)

        let openLicense = UIAlertAction(title: Alert.LICENSE_ACTION, style: .default) { _ in
            if let url = URL(string: "https://www.omdbapi.com/legal.htm") {
                UIApplication.shared.open(url)
            }
        }

        alertController.addAction(cancel)
        alertController.addAction(openLicense)

        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
