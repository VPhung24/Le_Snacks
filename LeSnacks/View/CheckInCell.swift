//
//  CheckInCell.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI

struct CheckInCell: View {
    @StateObject var restaurantViewModel = LeSnacksModelViewModel<Restaurant>()
    let restaurantId: String

    var body: some View {
        HStack {
            Text(restaurantViewModel.model?.name ?? "")
            Spacer()
            Text("\(restaurantViewModel.model?.rating ?? 0)")
        }
        .padding(.horizontal)
        .onAppear {
            restaurantViewModel.fetch(endpoint: .restaurantInfo(restaurantId))
        }
    }
}

struct CheckInCell_Previews: PreviewProvider {
    static var previews: some View {
        CheckInCell(restaurantId: "3UJANTHTqhg8LX1vADee")
    }
}
