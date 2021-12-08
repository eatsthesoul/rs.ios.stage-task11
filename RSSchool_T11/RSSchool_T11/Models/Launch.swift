//
//  Launch.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30.11.21.
//

import Foundation

struct Launch: Codable {
    
    let name: String?
    let success: Bool?
    let upcoming: Bool?
    let flightNumber: Int?
    let details: String?
    let launchDate: String?
    let staticFireDate: String?
    let rocket: String?
    let id: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case name
        case success
        case upcoming
        case flightNumber = "flight_number"
        case details
        case launchDate = "date_utc"
        case staticFireDate = "static_fire_date_utc"
        case rocket
        case id
        case links
    }
}

struct Links: Codable {
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let youtube: String?
    let wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch
        case reddit
        case flickr
        case youtube = "webcast"
        case wikipedia
    }
}

struct Patch: Codable {
    let small: String?
    let large: String?
}

struct Reddit: Codable {
    let campaign: String?
    let launch: String?
    let media: String?
    let recovery: String?
}

struct Flickr: Codable {
    let small: [String]?
    let original: [String]?
}
