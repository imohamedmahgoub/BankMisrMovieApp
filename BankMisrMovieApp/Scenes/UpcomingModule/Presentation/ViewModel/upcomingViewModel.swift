//
//  upcomingViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

class UpcomingViewModel {
    
    private let network = NetworkManager()
    
    var arr = [MovieDetailsEntity]()
    var pagesCount : Int?
    
    func getData(page : Int ,handler : @escaping (() -> Void)) {
        let path = "upcoming"
        network.getMovies(pageNumber: page, path: path, model: MovieEntity.self) { [weak self] response, error in
            guard let self else { return }
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if let response {
                arr.append(contentsOf: response.results ?? [])
                pagesCount = response.totalPages
                handler()
                return
            }
        }
    }
    
}

