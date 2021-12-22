//
//  Launchpad.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 20.12.21.
//

import Foundation

struct Launchpad: Codable {
    let name: String?
    let fullName: String?
    let locality: String?
    let region: String?
    let timezone: String?
    let latitude: Double?
    let longitude: Double?
    let launchAttempts: Int?
    let launchSuccesses: Int?
    let rockets: [String]
    let launches: [String]
    let status: String
    let details: String?
    let id: String?
    let images: LaunchpadImages?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case locality
        case region
        case timezone
        case latitude
        case longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets
        case launches
        case status
        case details
        case id
        case images
    }
}

struct LaunchpadImages: Codable {
    let large: [String]?
}
