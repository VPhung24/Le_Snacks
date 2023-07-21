//
//  ProfileView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame(height: 300)
            HStack(alignment: .center) {
                Text("Resturant")
                Spacer()
                Text("Rating")
            }
            .padding(20)
            Spacer()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
