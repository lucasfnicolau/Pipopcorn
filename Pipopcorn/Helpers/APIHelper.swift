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

class APIHelper {
    let shared = APIHelper()

    private init() { }

    func decodeJSON<T: Codable>(fromURL url: String, for model: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) {

        guard let url = URL(string: url),
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
