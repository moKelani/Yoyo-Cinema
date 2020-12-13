//
//  NetworkTests.swift
//  YoyoCinemaTests
//
//  Created by Mohamed Kelany on 12/8/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import XCTest
@testable import YoyoCinema

class APIServiceTests: XCTestCase {

    func testSuccessfulResponse() {
        // Setup our objects
        let session = URLSessionMock()
        let manager = APIService(session: session)

        // Create data and tell the session to always return it
        let data = DataLoader.getData()
        session.data = data

        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")

        // Perform the request and verify the result

        manager.loadData(from: url) { (result: Result<MovieList, APIError>) in

            switch result {
            case .success(let movieList):
                XCTAssertGreaterThan(movieList.results.count, 0)
            default:
                XCTFail("Can't get Data")
            }
        }
        
    }

}
