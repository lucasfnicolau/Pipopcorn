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
        getMovieDetails()
    }

    func getMovieDetails() {
        let fullURL = "\(ENDPOINT)=\(API_KEY)&i=\(imdbID)"

        DispatchQueue.main.async {
            guard let url = URL(string: fullURL),
                let data = try? Data(contentsOf: url) else { return }

            if let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: data) {
                self.movieDetails = movieDetails
                self.fillTableView()
            } else {
                print("Algo deu errado :(")
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
