//
//  BankMisrMovieAppTests.swift
//  BankMisrMovieAppTests
//
//  Created by Mohamed Mahgoub on 27/09/2024.
//

import XCTest
@testable import BankMisrMovieApp

final class NetworkManagerTests: XCTestCase {
    
    let network : NetworkManagerProtocol = NetworkManager()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testFetchDataFromApi() {
        let exp = expectation(description: "Waiting Api...")
        network.getMovies(pageNumber: 1, path: "now_playing", model: MovieEntity.self) { response, error in
            if let error {
                XCTFail()
            }else{
                XCTAssertEqual(response?.results?.first?.title, "The Crow")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 3)
    }
}
