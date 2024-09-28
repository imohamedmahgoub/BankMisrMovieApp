//
//  MovieDetailsViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func getMovieDetails(handler: @escaping (()-> Void))
    var detailsArray : [MovieDetailsResponse] { get }
    var id : Int { get set }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var id = 0
    private var network: NetworkManagerMovieDetailsProtocol?
    var detailsArray = [MovieDetailsResponse]()
    
    func getMovieDetails(handler: @escaping (()-> Void)){
        network = NetworkManager()
        network?.getMovieDetails(movieId: id, model: MovieDetailsResponse.self) { response, error in
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
