//
//  LoginProviderCell.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import SnowballAssetKit

struct LoginProviderCell: View {
    @Binding var userIsAuthenticated: Bool
    let provider: LoginProvider
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // to do: fix coloring
            SnowballImage(provider.icon)
            
            Text(provider.title.capitalized(with: .current))
                .foregroundColor(.primary)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "arrow.up.right")
                .foregroundColor(Color(UIColor.quaternaryLabel))
                .font(.subheadline)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(12)
        .onTapGesture {
            userIsAuthenticated = true
        }
    }
}

struct LoginProviderCell_Previews: PreviewProvider {
    static var previews: some View {
        LoginProviderCell(userIsAuthenticated: .constant(false), provider: LoginProvider(.metamask))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
