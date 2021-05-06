//
//  Planet.swift
//  Planets
//
//  Created by SOM on 04/05/21.
//

import Foundation

///Struct to be used as Object model to store data received from server
struct AllPlanets: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Planet]
}

struct Planet: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let created: String
    let edited: String
    let url: String
    let residents: [String]
    let films: [String]
}
