//
//  MoviesResponse.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import Foundation

struct MovieEntity: Codable {
    let page: Int?
    let results: [MovieDetailsEntity]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(results, forKey: .results)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
    
    func jsonData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

struct MovieDetailsEntity: Codable {
    let id: Int?
    let posterPath, releaseDate, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

