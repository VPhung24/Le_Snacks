//
//  RestaurantView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI
import SnowballSwiftKit

struct RestaurantView: View {
    let address: String
    let restaurant: Restaurant
    @StateObject private var viewModel = LeSnacksModelViewModel<String>()

    var body: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name)
                .font(.title)
            Text(restaurant.cuisine)
                .font(.body)
            Text(restaurant.address)
                .font(.caption)

            Button {
                viewModel.fetch(endpoint: .checkin(restaurant.id), parameters: ["wallet_address": address])
            } label: {
                HStack(spacing: 4) {
                    Text("Check In")
                        .font(.subheadline.bold())
                    Image(systemName: "arrow.up.right")
                        .font(.subheadline.bold())
                }
                .lineSpacing(20)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(SnowballButtonStyle.snowballTinted(.large))
        }
        .padding()
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b", restaurant: Restaurant(id: "sdsada", name: "food", url: "blah", rating: 4.0, cuisine: "sushi", address: "asddasd", geolocation: Geolocation(latitude: 2.0, longitude: 3.0)))
    }
}
