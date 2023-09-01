//
//  Planet.swift
//  PlanetCombine
//
//  Created by Consultant on 8/1/23.
//

import Foundation

struct Planet: Decodable{
    let count: Int
    var previous: String?
    var next: String?
    let results: [Result]
}


struct Result: Decodable, Identifiable{
    var id: String = UUID().uuidString
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
