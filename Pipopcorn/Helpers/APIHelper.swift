//
//  APIHelper.swift
//  Pipopcorn
//
//  Created by Lucas Fernandez Nicolau on 27/03/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

enum APIError: Error {
    case urlFetchError
    case jsonDecodeError
}

enum APIPurpose: String {
    case search = "s"
    case details = "i"
}

class APIHelper {

    let ENDPOINT = "https://www.omdbapi.com/?apikey"
    static let shared = APIHelper()

    private init() { }

    func formatToQueryString(_ string: String) -> String {
        return string.components(separatedBy: " ").joined(separator: "%20")
    }

    func searchMovies(named name: String, completionHandler: @escaping (Result<[Movie], APIError>) -> Void) {
        decodeJSON(for: .search, using: Search.self, andQuery: name) { result in
            switch result {
                case .success(let search):
                    completionHandler(.success(search.movies))
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }

    func getMovieDetails(forId id: String, completionHandler: @escaping (Result<MovieDetails, APIError>) -> Void) {

        decodeJSON(for: .details, using: MovieDetails.self, andQuery: id) { result in
            switch result {
                case .success(let movieDetails):
                    completionHandler(.success(movieDetails))
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
    }

    private func decodeJSON<T: Codable>(for purpose: APIPurpose, using model: T.Type, andQuery query: String, completionHandler: @escaping (Result<T, APIError>) -> Void) {

        let urlPurpose = purpose.rawValue
        let queryString = formatToQueryString(query)

        guard let url = URL(string: "\(ENDPOINT)=\(API_KEY)&\(urlPurpose)=\(queryString)&type=movie"),
              let data = try? Data(contentsOf: url) else {
                completionHandler(.failure(.urlFetchError))
                return
        }

        if let decodedModel = try? JSONDecoder().decode(model.self, from: data) {
            completionHandler(.success(decodedModel))
        } else {
            completionHandler(.failure(.jsonDecodeError))
        }
    }
}
