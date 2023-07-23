//
//  ProofOfSnacksView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI

struct ProofOfSnacksView: View {
    @StateObject var proofOfSnacksRestaurants = LeSnacksModelsViewModel<Restaurant>()
    let address: String
    
    var body: some View {
        ScrollView {
            ForEach(proofOfSnacksRestaurants.models, id: \.id) { restaurant in
                if let poapURL = restaurant.poapUri, let url = URL(string: "https://ipfs.io/ipfs/\(poapURL).png") {
                    AsyncImage(url: url)
                        .scaledToFit()
                        .padding()
                }
            }
        }
        .onAppear {
            proofOfSnacksRestaurants.fetch(endpoint: .proofOfSnacks(address))
        }
    }
}

struct ProofOfSnacksView_Previews: PreviewProvider {
    static var previews: some View {
        ProofOfSnacksView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b")
    }
}
