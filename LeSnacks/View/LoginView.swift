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
    @State var presentAuthView: Bool = false
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
                
                VStack {
                    LoginProviderCell(presentAuthView: $presentAuthView, provider: LoginProvider(.metamask))
                    LoginProviderCell(presentAuthView: $presentAuthView, provider: LoginProvider(.walletConnect))
                    // to do: gnosis
                    LoginProviderCell(presentAuthView: $presentAuthView, provider: LoginProvider(.walletConnect))
                    LoginProviderCell(presentAuthView: $presentAuthView, provider: LoginProvider(.snowball))
                }
            }
        }
        .padding()
        .sheet(isPresented: $presentAuthView) {
            WalletConnectAuthView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
