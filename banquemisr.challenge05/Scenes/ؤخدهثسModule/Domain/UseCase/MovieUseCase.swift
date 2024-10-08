//
//  MovieUseCase.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation

protocol MovieUseCaseProtocol {
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result: MovieEntity?, _ error: Error?) -> Void))
    func saveMovies(type:String, _ movie: MovieEntity)
}

class MovieUseCase: MovieUseCaseProtocol {
    private let repo : MovieRepoProtocol
    
    init(repo: MovieRepoProtocol = MovieRepo()) {
        self.repo = repo
    }
    
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result: MovieEntity?, _ error: Error?) -> Void)) {
        repo.getMovie(pageNumber: pageNumber, path: path, handler: handler)
    }
    
    func saveMovies(type:String, _ movie: MovieEntity) {
        repo.saveMovies(type: type, movie)
    }
}
