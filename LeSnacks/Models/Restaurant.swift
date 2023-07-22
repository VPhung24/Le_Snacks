//
//  Restaurant.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation
import CoreLocation

struct Restaurant: Codable, Identifiable {
    let name: String
    let url: String
    let rating: Float
    let cuisine: String
    let address: String
    let geolocation: Geolocation

    var id: String { url }
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
