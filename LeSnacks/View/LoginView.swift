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
    @State var showWalletConnectSheet: Bool = false
    
    @StateObject var viewModel = AuthViewModel()
    
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

                ForEach(AuthMethods.allCases, id: \.self) { auth in
                    LoginProviderCell(provider: auth)
                        .onTapGesture {
                            if auth == .walletconnect {
                                viewModel.setupWalletConnectInitialState()
                                showWalletConnectSheet = true
                            } else {
                                viewModel.authenticate(for: auth)
                            }
                        }
                }
            }
        }
        .padding()
        .sheet(isPresented: $showWalletConnectSheet) {
            VStack {
                ForEach(Wallets.allCases, id: \.self) { wallet in
                    LoginProviderCell(provider: wallet)
                        .onTapGesture {
                            viewModel.authenticate(for: .walletconnect, wallet: wallet)
                        }
                }
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
