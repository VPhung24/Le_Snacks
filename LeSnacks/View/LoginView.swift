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
    @State var presentMapView: Bool = false
    
    var body: some View {
        NavigationStack {
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
                        LoginProviderCell(userIsAuthenticated: $presentMapView, provider: LoginProvider(.metamask))
                        LoginProviderCell(userIsAuthenticated: $presentMapView, provider: LoginProvider(.walletConnect))
                        
                        // to do: gnosis
                        LoginProviderCell(userIsAuthenticated: $presentMapView, provider: LoginProvider(.walletConnect))
                        LoginProviderCell(userIsAuthenticated: $presentMapView, provider: LoginProvider(.snowball))
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $presentMapView) {
                MapView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
