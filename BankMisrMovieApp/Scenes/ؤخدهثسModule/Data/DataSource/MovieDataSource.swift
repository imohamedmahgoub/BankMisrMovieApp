//
//  MovieDataSource.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation

protocol MovieDataSourceProtocol {
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result : MovieEntity?, _ error: Error?) -> Void))
}

struct MovieDataSource: MovieDataSourceProtocol {
    
    private let network : NetworkManagerProtocol = NetworkManager()
    
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result : MovieEntity?, _ error: Error?) -> Void)) {
        network.getMovies(
            pageNumber: pageNumber,
            path: path,
            model: MovieEntity.self,
            handler: handler
        )
    }
}
