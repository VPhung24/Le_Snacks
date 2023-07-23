//
//  Review.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation

struct Review: Codable, Hashable {
    let walletAddress: String
    let restaurantId: String
    let rating: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case walletAddress = "wallet_address"
        case restaurantId = "restaurant_id"
        case rating
        case text
    }
}
