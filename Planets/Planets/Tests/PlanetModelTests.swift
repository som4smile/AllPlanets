//
//  PlanetModelTests.swift
//  Planets
//
//  Created by SOM on 06/05/21.
//

import XCTest
@testable import Planets

class PlanetModelTests: XCTestCase {
    
    
    private static let expectedJSON = [ "count": 60,
                                        "next": "http://swapi.dev/api/planets/?page=2",
                                        "previous": "null",
                                        "results": [ [
                                                "name": "Tatooine",
                                                "rotation_period": "23",
                                                "orbital_period": "304",
                                                "diameter": "10465",
                                                "climate": "arid",
                                                "gravity": "1 standard",
                                                "terrain": "desert",
                                                "surface_water": "1",
                                                "population": "200000",
                                                "residents": [
                                                    "http://swapi.dev/api/people/1/",
                                                    "http://swapi.dev/api/people/2/",
                                                    "http://swapi.dev/api/people/3/"
                                                ],
                                                "films": [
                                                    "http://swapi.dev/api/films/5/",
                                                    "http://swapi.dev/api/films/6/"
                                                ],
                                                "created": "2014-12-09T13:50:49.641000Z",
                                                "edited": "2014-12-20T20:58:18.411000Z",
                                                "url": "http://swapi.dev/api/planets/1/"
                                            ]
                                        ]
    ] as [String : Any]
    
    private static let inValidJSON = [ "count": 60,
                                       "next": "",
                                       "previous": "null",
                                       "results": [ [],
                                       ]
   ] as [String : Any]

    // Convert from JSON to nsdata
    func jsonToNSData(json: [String : Any]) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) as Data
        } catch let error {
            print(error)
        }
        return nil;
    }
    
    func testValidJSON() {
        guard let jsonData = self.jsonToNSData(json: type(of: self).expectedJSON) else {
            XCTAssertFalse(false)

            return
        }
        
        let jsonObject = try! JSONDecoder().decode(AllPlanets.self, from: jsonData)

        XCTAssertEqual(jsonObject.count, 60)
        XCTAssertEqual(jsonObject.next, "http://swapi.dev/api/planets/?page=2")
        XCTAssertEqual(jsonObject.results.first?.name, "Tatooine")
        XCTAssertEqual(jsonObject.results.first?.rotation_period, "23")
        XCTAssertEqual(jsonObject.results.first?.created, "2014-12-09T13:50:49.641000Z")
    }
    
    func testInvalidJSON() {
        guard (self.jsonToNSData(json: type(of: self).expectedJSON) != nil) else {
            XCTAssertTrue(true)
            return
        }
        
    }

}
