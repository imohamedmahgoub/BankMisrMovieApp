//
//  DetailsResponse.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

// MARK: - MovieDetailsResponse
struct MovieDetailsResponse: Codable {
    let backdropPath: String?
    let genres: [Genre]?
    let homepage: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title, originalLanguage: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, homepage
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

