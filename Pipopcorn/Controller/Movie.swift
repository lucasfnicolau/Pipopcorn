//
//  Movie.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 27/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}
