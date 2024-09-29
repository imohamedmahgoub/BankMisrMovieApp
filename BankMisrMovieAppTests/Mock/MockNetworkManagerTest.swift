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
        mock = MockNetworkManager(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
    }
    
    func testMocking() {
        mock.getMovies(pageNumber: 1, path: "now_playing", model: MovieEntity.self) { result, error in
            if let error {
                XCTFail()
            }else {
                XCTAssertNotNil(result)
            }
        }
    }
    


}
