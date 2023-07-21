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
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                VStack {
                    LoginProviderCell(provider: LoginProvider(.metamask))
                    LoginProviderCell(provider: LoginProvider(.walletConnect))
                    LoginProviderCell(provider: LoginProvider(.walletConnect))
                    LoginProviderCell(provider: LoginProvider(.snowball))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .padding()
    }
}
