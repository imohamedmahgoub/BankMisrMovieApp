//
//  NetworkManager.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getMovies<T: Codable> (pageNumber: Int?, path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    func getMovies<T: Codable> (pageNumber: Int?, path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void) {
        guard var url = URL(string: "\(baseUrl)\(path)") else {
            handler(nil, NetworkError.invalidURL)
            return
        }
        var urlQuaryItems = [URLQueryItem(name: "api_key", value: "4bc428766cc04018cb0b4cd2755baa97")]
        if let pageNumber {
            urlQuaryItems.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        }
        url.append(queryItems: urlQuaryItems)
        URLSession.shared.dataTask(with: url) { data, _, error in
            do{
                guard let data else {
                    handler(nil, error)
                    return
                }
                let result = try? JSONDecoder().decode(model, from: data)
                handler(result, nil)
            }
        }.resume()
    }
}
enum NetworkError: Error {
    case invalidURL
}
