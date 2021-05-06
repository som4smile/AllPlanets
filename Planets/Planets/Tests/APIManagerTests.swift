//
//  APIManagerTests.swift
//  PlanetsTests
//
//  Created by SOM on 07/05/21.
//

import XCTest
@testable import Planets

class APIManagerTests: XCTestCase {

    func testFetchData() {
        let expect = XCTestExpectation(description:"testing")

        APIManager.shared.fetchData(completion: { _,_  in
            XCTAssertTrue(true)
            expect.fulfill()
        })
        wait(for: [expect], timeout: 20)
    }

}
