//
//  Restaurant.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation
import CoreLocation

struct Restaurant: Codable, Identifiable {
    var id: String
    let name: String
    let url: String
    let rating: Float
    let cuisine: String
    let address: String
    let geolocation: Geolocation
    let poapUri: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case rating
        case cuisine
        case address
        case geolocation
        case poapUri = "poap_uri"
    }
}

struct Geolocation: Codable {
    let latitude: Double
    let longitude: Double
}

extension Geolocation {
    var clLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
