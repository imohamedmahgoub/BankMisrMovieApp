//
//  MovieRepo.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation

protocol MovieRepoProtocol {
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result: MovieEntity?, _ error: Error?) -> Void))
}

struct MovieRepo: MovieRepoProtocol{
    private let dataSource : MovieDataSourceProtocol = MovieDataSource()
    
    func getMovie(pageNumber: Int, path: String, handler: (@escaping(_ result: MovieEntity?, _ error: Error?) -> Void)) {
        if InternetConnectivity.hasInternetConnect() {
            dataSource.getMovie(pageNumber: pageNumber, path: path, handler: handler)
        }else{
            print("No Internet")
        }
    }
}
