//
//  MovieDetailsUseCase.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation

protocol MovieDetailsUseCaseProtocol {
    func getMovieDetails(id: Int, handler: @escaping((_ result: MovieDetailsResponse?, _ error: Error? ) -> Void))
}

struct MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let repo : MovieDetailsRepoProtocol
    
    init(repo : MovieDetailsRepoProtocol = MovieDetailsRepo()){
        self.repo = repo
    }
    
    func getMovieDetails(id: Int, handler: @escaping((_ result: MovieDetailsResponse?, _ error: Error? ) -> Void)){
        repo.getMovieDetails(id: id, handler: handler)
    }
}
