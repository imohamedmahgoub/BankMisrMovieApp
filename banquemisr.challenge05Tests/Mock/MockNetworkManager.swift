//
//  MockNetworkManager.swift
//  BankMisrMovieAppTests
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import Foundation
@testable import BankMisrMovieApp

class MockNetworkManager {
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let data : [String:Any] = [
        "page": 1,
        "results": [
            [
                "adult": false,
                "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg",
                "genre_ids": [
                    28,
                    14,
                    27
                ],
                "id": 957452,
                "original_language": "en",
                "original_title": "The Crow",
                "overview": "Soulmates Eric and Shelly are brutally murdered when the demons of her dark past catch up with them. Given the chance to save his true love by sacrificing himself, Eric sets out to seek merciless revenge on their killers, traversing the worlds of the living and the dead to put the wrong things right.",
                "popularity": 1940.634,
                "poster_path": "/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg",
                "release_date": "2024-08-21",
                "title": "The Crow",
                "video": false,
                "vote_average": 5.378,
                "vote_count": 418
            ],
            [
                "adult": false,
                "backdrop_path": "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
                "genre_ids": [
                    28,
                    35,
                    878
                ]
            ]
        ]
    ]
}

extension MockNetworkManager {
    
    enum responseError : Error {
        case responseError
    }
    
    func getMovies<T: Codable> (pageNumber: Int?, path: String, model: T.Type, handler: @escaping (T?, Error?) -> Void) {
        
        do {
            
            var jsonData = try JSONSerialization.data(withJSONObject: data)
            let  result = try JSONDecoder().decode(T.self, from: jsonData)
            
            if shouldReturnError {
                handler(nil,responseError.responseError)
            }else{
                handler(result ,nil)
            }
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
}
