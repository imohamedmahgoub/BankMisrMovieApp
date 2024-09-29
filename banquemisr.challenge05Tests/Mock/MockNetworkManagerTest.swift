//
//  MockNetworkManagerTest.swift
//  BankMisrMovieAppTests
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import XCTest
@testable import BankMisrMovieApp

final class MockNetworkManagerTest: XCTestCase {
    
    var mock : MockNetworkManager!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testMockNetworkManagerSuccess() {
        
        mock = MockNetworkManager(shouldReturnError: false)
        mock.getMovies(pageNumber: 1, path: "now_playing", model: MovieEntity.self) { result, error in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.results?.first?.title, "The Crow")
        }
    }

    func testMockNetworkManagerError() {
        mock = MockNetworkManager(shouldReturnError: true)
        mock.getMovies(pageNumber: 1, path: "now_playing", model: MovieEntity.self) { result, error in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
        }
    }



}
