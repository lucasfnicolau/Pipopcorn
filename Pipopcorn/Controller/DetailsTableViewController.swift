//
//  DetailsTableViewController.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 26/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    var movieDetails: MovieDetails?
    var imdbID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
    }

    func fetchMovieDetails() {
        DispatchQueue.main.async {
            APIHelper.shared.getMovieDetails(forId: self.imdbID) { result in
                switch result {
                case .success(let movieDetails):
                    self.movieDetails = movieDetails
                    self.fillTableView()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func fillTableView() {
        guard let movieDetails = movieDetails else { return }
        nameLabel.text = movieDetails.title
        releaseDateLabel.text = movieDetails.released
        ratingLabel.text = movieDetails.rated
        directorLabel.text = movieDetails.director
        imdbRatingLabel.text = movieDetails.imdbRating
        posterImageView.load(url: movieDetails.poster)
    }
}
