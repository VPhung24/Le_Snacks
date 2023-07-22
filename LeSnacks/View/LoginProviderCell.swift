//
//  LoginProviderCell.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import SnowballAssetKit

struct LoginProviderCell<T: LoginProviderCellModel>: View {
    let provider: T

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // to do: fix coloring
            provider.icon

            Text(provider.title)
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
    }
}

struct LoginProviderCell_Previews: PreviewProvider {
    static var previews: some View {
        LoginProviderCell<AuthMethods>(provider: .metamask)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

protocol LoginProviderCellModel {
    var icon: Image { get }
    var title: String { get }
}
