//
//  MovieDetailsRepo.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation

protocol MovieDetailsRepoProtocol {
    func getMovieDetails(id: Int, handler: @escaping((_ result: MovieDetailsResponse?, _ error: Error? ) -> Void))
}

struct MovieDetailsRepo: MovieDetailsRepoProtocol {
    
    private let dataSource : MovieDetailsDataSourceProtocol
    
    init(dataSource : MovieDetailsDataSourceProtocol = MovieDetailsDataSource()){
        self.dataSource = dataSource
    }
    
    func getMovieDetails(id: Int, handler: @escaping((_ result: MovieDetailsResponse?, _ error: Error? ) -> Void)){
        if InternetConnectivity.hasInternetConnect() {
            dataSource.getMovieDetails(id: id, handler: handler)
        }else{
            print("No Internet")
        }
    }
}
