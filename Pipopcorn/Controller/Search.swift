//
//  Search.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 27/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

struct Search: Codable {
    let search: [Movie]
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
    }
}
