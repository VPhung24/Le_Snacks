//
//  ProfileView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import SnowballSwiftKit

struct ProfileView: View {
    let address: String
    @StateObject var reviewsViewModel = LeSnacksModelViewModel<User>()

    var body: some View {
        VStack {
            if let user = reviewsViewModel.model {
                AsyncImage(url: URL(string: user.profilePictureUrl!))
                    .scaledToFit()
                ScrollView {
                    ForEach(user.visitedRestaurants, id: \.self) { restaurant in
                        CheckInCell(restaurantId: restaurant)
                    }
                }
                Button {
                    UIApplication.shared.open(URL(string: "http://testnets.opensea.io/assets/goerli/0x29381c61f54c59d690cb88ca588748ef2fffd075/\(user.tummyTokenId)")!)
                } label: {
                    HStack(spacing: 4) {
                        Text("Open on OpenSea")
                            .font(.subheadline.bold())
                        Image(systemName: "arrow.up.right")
                            .font(.subheadline.bold())
                    }
                    .lineSpacing(20)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(SnowballButtonStyle.snowballTinted(.large))
                .padding()
            }
            Spacer()
        }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .tabItem {
            Label("Profile", systemImage: "person.crop.circle.fill")
        }
        .onAppear {
            reviewsViewModel.fetch(endpoint: .getUser(address))
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b")
    }
}
