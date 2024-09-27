//
//  NetworkManager.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
}

protocol NetworkManagerProtocol {
    func getMovies<T: Codable> (pageNumber: Int, path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void)
}

class NetworkManager : NetworkManagerProtocol {
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    func getMovies<T: Codable> (pageNumber: Int, path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void) {
        guard var url = URL(string: "\(baseUrl)\(path)") else {
            handler(nil, NetworkError.invalidURL)
            return
        }
        let urlQuaryItem1 = URLQueryItem(name: "api_key", value: "4bc428766cc04018cb0b4cd2755baa97")
        let urlQuaryItem2 = URLQueryItem(name: "page", value: "\(pageNumber)")
        
        url.append(queryItems: [urlQuaryItem1,urlQuaryItem2])                
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
    
    func getMovieDetails<T: Codable> (movieId: Int, model: T.Type,handler: @escaping (T?, Error?) -> Void){
        guard var url = URL(string: "\(baseUrl)\(movieId)") else {
            handler(nil, NetworkError.invalidURL)
            return
        }
        let urlQuaryItem = URLQueryItem(name: "api_key", value: "4bc428766cc04018cb0b4cd2755baa97")
        url.append(queryItems: [urlQuaryItem])
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
