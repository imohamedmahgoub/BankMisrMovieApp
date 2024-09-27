//
//  NetworkManager.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
}

protocol NetworkManagerProtocol {
    func getMovies<T: Codable> (path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void)
}

class NetworkManager : NetworkManagerProtocol {
    private let apiKey = "api_key=4bc428766cc04018cb0b4cd2755baa97"
    private let baseUrl = "https://api.themoviedb.org/3/discover/movie?"
    
    func getMovies<T: Codable> (path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(apiKey)\(path)") else {
            handler(nil, NetworkError.invalidURL)
            return
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
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
