//
//  ProfileView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI

struct ProfileView: View {
    let address: String
    @StateObject var reviewsViewModel = LeSnacksModelsViewModel<Review>()

    var body: some View {
        VStack {
            if let user = reviewsViewModel.user {
                AsyncImage(url: URL(string: user.profilePictureUrl!))
                    .scaledToFit()
                ForEach(user.visitedRestaurants, id: \.self) { restaurant in
                    CheckInCell(restaurantId: restaurant)
                }
            }

            Spacer()
        }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .tabItem {
            Label("Profile", systemImage: "person.crop.circle.fill")
        }
        .onAppear {
            reviewsViewModel.fetch(endpoint: .getReviewFromAddress(address))
            reviewsViewModel.fetchUserModel(endpoint: .getUser(address))
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b")
    }
}
