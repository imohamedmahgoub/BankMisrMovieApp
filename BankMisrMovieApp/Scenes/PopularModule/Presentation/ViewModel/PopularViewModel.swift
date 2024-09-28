//
//  PopularViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

protocol ViewModelProtocol {
    func getData(page: Int ,handler: @escaping (() -> Void))
    var movieArray : [MovieDetailsEntity] { get }
    var pagesCount: Int? { get }
}

class PopularViewModel: ViewModelProtocol {
    
    private var network: NetworkManagerProtocol?
    var movieArray = [MovieDetailsEntity]()
    var pagesCount: Int?
    
    func getData(page: Int ,handler: @escaping (() -> Void)) {
        let path = "popular"
        network = NetworkManager()
        network?.getMovies(pageNumber: page, path: path, model: MovieEntity.self) { [weak self] response, error in
            guard let self else { return }
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if let response {
                movieArray.append(contentsOf: response.results ?? [])
                pagesCount = response.totalPages
                handler()
                return
            }
        }
    }
}
