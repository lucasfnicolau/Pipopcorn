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
        guard let text = nameTextField.text,
            text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
        nameTextField.resignFirstResponder()

        let name = text.trimmingCharacters(in: .whitespacesAndNewlines)

        movies = []
        self.tableView.reloadData()
        APIHelper.shared.searchMovies(named: name) { result in
            switch result {
                case .success(let movies):
                    self.movies = movies.filter { $0.type == .movie }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
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
        tableView.reloadData()
    }

    @objc func dismissKeyboard() {
        nameTextField.resignFirstResponder()
    }
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count > 0 ? movies.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if movies.isEmpty {
            return tableView.dequeueReusableCell(withIdentifier: CellID.NO_MOVIE_CELL) as! NoMovieTableViewCell
        }

        if let cell = tableView.dequeueReusableCell(withIdentifier: CellID.MOVIE_CELL) as? MovieTableViewCell {
            cell.setup(for: movies[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.7
    }

}

extension MoviesViewController: UITableViewDelegate { }

extension MoviesViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTouched(UIButton())
        return false
    }

}
