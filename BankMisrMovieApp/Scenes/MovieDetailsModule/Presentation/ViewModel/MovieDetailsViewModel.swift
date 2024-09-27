//
//  MovieDetailsViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

class MovieDetailsViewModel {
    var id = 0
    var network = NetworkManager()
    var detailsArray = [MovieDetailsResponse]()
    
    func getMovieDetails(handler: @escaping (()-> Void)){
        network.getMovieDetails(movieId: id, model: MovieDetailsResponse.self) { response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            if let response {
                self.detailsArray = [response]
                handler()
                return
            }
        }
    }
}
