//
//  LeSnacksEndpoint.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation

enum LeSnacksEndpoints: Endpoint {
    case restaurants
    case postReview
    case getReviewFromRestaurantId(_ restaurantId: String)
    case getReviewFromAddress(_ address: String)
    case getUser(_ address: String)
    case checkin(_ restaurantId: String)
    case restaurantInfo(_ restaurantId: String)

    var path: String {
        switch self {
        case .restaurants:
            return "/restaurants"
        case .getUser(let address):
            return "/users/\(address)"
        case .postReview:
            return "/restaurants/{restaurant_id}/reviews"
        case .getReviewFromRestaurantId(let restaurantId):
            return "/restaurants/\(restaurantId)/reviews"
        case .getReviewFromAddress(let address):
            return "/users/\(address)/reviews"
        case .checkin(let restaurantId):
            return "/restaurants/\(restaurantId)/checkin"
        case .restaurantInfo(let restaurantId):
            return "/restaurants/\(restaurantId)"
        }
    }

    var method: Method {
        switch self {
        case .postReview, .checkin:
            return .POST
        default:
            return .GET
        }
    }
}
