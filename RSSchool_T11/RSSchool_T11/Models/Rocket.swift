//
//  Rocket.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import Foundation

struct Rocket: Codable {
    let name: String?
    let firstLaunch: Date?
    let launchCost: Double?
    let success: Double?
    let description: String?
    let mass: Mass?
    let height: RocketSize?
    let diameter: RocketSize?
    let images: [String]?
    let engines: RocketEngines?
//    let stage: RocketStage
    
    enum CodingKeys: String, CodingKey {
        case name
        case firstLaunch = "first_flight"
        case launchCost = "cost_per_launch"
        case success = "success_rate_pct"
        case description
        case mass
        case height
        case diameter
        case images = "flickr_images"
        case engines
//        case stage
    }
}

struct Mass: Codable {
    let kg: Double?
    let lb: Double?
}

struct RocketSize: Codable {
    let meters: Double?
    let feet: Double?
}

struct RocketEngines: Codable {
    let type: String?
    let layout: String?
    let version: String?
    let number: Int?
    let propellant1: String?
    let propellant2: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case layout
        case version
        case number
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
    }
}

struct RocketStage: Codable {
    let reusable: Bool?
    let engines: Int?
    let fuelAmount: Double?
    let burningTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelAmount = "fuel_amount_tons"
        case burningTime = "burn_time_sec"
    }
}


