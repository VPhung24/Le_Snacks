//
//  HomeView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI

struct HomeView: View {
    let address: String

    var body: some View {
        TabView {
            ProfileView(address: address)
            MapView(address: address)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b")
    }
}
