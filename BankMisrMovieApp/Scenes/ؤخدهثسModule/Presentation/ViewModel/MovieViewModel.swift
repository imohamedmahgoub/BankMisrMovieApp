//
//  NowPlayingViewModel.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

protocol MovieViewModelProtocol {
    func getData(page : Int ,handler : @escaping (() -> Void))
    var movieArray : [MovieDetailsEntity] { get }
    var pagesCount : Int? { get }
}

class MovieViewModel: MovieViewModelProtocol{
    
    private var useCase : MovieUseCaseProtocol
    var movieArray = [MovieDetailsEntity]()
    var pagesCount : Int?
    private var type : TabBarSreen
    
    init(type : TabBarSreen, useCase: MovieUseCaseProtocol = MovieUseCase()) {
        self.type = type
        self.useCase = useCase
    }
    
    func getData(page : Int ,handler : @escaping (() -> Void)) {
        let path = type.rawValue
        useCase.getMovie(pageNumber: page, path: path) { [weak self] response, error in
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

