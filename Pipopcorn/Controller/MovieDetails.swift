//
//  MovieDetails.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 27/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let imdbID,
        title,
        rated,
        released,
        director,
        imdbRating,
        poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case rated  = "Rated"
        case released = "Released"
        case director = "Director"
        case poster = "Poster"
        case imdbRating, imdbID
    }
}
