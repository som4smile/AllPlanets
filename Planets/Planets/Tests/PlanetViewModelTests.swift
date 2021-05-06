//
//  PlanetViewModelTests.swift
//  PlanetsTests
//
//  Created by SOM on 07/05/21.
//

import XCTest
@testable import Planets

class PlanetViewModelTests: XCTestCase {
        
    func testFetchData(){
        let expect = XCTestExpectation(description:"testing")

        PlanetViewModel.shared.fetchData(completionHandler: { error in
            XCTAssertTrue(true)
            expect.fulfill()
        })
        wait(for: [expect], timeout: 20)
    }
}
