//
//  LoginView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import SnowballSwiftKit
import SnowballAssetKit

struct LoginView: View {
    @State var presentAuthView: LeSnacksAuth = .none
    @StateObject private var viewModel = WalletConnectAuthViewModel()

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Login")
                        .font(.title.bold())
                        .kerning(0.36)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Text("Don't have an account? We'll make one for you")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)

                ForEach(LeSnacksAuth.allCases.dropLast(), id: \.self) { auth in
                    LoginProviderCell(presentAuthType: $presentAuthView, provider: auth)
                }
            }
        }
        .padding()
        .sheet(isPresented: .constant(presentAuthView != .none)) {
            switch presentAuthView {
            case .metamask:
                MetaMaskAuthView()
            case .walletconnect:
                WalletConnectAuthView(viewModel: viewModel)
            default:
                Text("Snowball Auth")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
