//
//  MovieDetailsViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func getMovieDetails(handler: @escaping ((_ data: MovieDetailsResponse)-> Void))  
    var genres : [Genre] { get }
    var movieUrl: String? { get }
}
class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    private var useCase: MovieDetailsUseCaseProtocol
    private var id: Int
    var genres = [Genre]()
    var movieUrl: String?
    
    init(id: Int, useCase: MovieDetailsUseCaseProtocol = MovieDetailsUseCase()) {
        self.id = id
        self.useCase = useCase
    }
    
    func getMovieDetails(handler: @escaping ((_ data: MovieDetailsResponse)-> Void)){
        useCase.getMovieDetails(id: id) {[weak self] response, error in
            guard let self else {return}
            if let error {
                print(error.localizedDescription)
                return
            }
            if let response {
                self.genres = response.genres ?? []
                self.movieUrl = response.homepage
                handler(response)
                return
            }
        }
    }
}
