//
//  User.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation

struct User: Codable {
    let id: String
    let walletAddress: String
    let worldId: String?
    let visitedRestaurants: [String]
    let reviews: [Review]
    let tummyTokenId: Int
    let profilePictureUrl: String?
    let tummy6551Account: String?

    enum CodingKeys: String, CodingKey {
        case id
        case walletAddress = "wallet_address"
        case worldId = "world_id"
        case visitedRestaurants = "visited_restaurants"
        case reviews
        case tummyTokenId = "tummy_token_id"
        case profilePictureUrl = "profile_picture_url"
        case tummy6551Account = "tummy_6551_account"
    }
}
