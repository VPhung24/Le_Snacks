//
//  LoginView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import Combine
import SnowballSwiftKit
import SnowballAssetKit
import metamask_ios_sdk

struct LoginView: View {
    @State var presentWalletConnectView: Bool = false
    @StateObject private var viewModel = WalletConnectAuthViewModel()

    @StateObject var userViewModel: LeSnacksModelViewModel<User>

    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
    @State private var cancellables: Set<AnyCancellable> = []

    private let dapp = Dapp(name: "Le Snacks", url: "https://lesnacks.xyz")

    @State private var errorMessage = ""

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

                ForEach(AuthProvider.allCases, id: \.self) { auth in
                    LoginProviderCell(provider: auth)
                        .onTapGesture {
                            onTap(auth: auth)
                        }
                }
            }
        }
        .padding()
        .sheet(isPresented: $presentWalletConnectView) {
            ForEach(WalletConnectProviders.allCases, id: \.self) { auth in
                LoginProviderCell(provider: auth)
                    .onTapGesture {
                        onTap(auth: .walletconnect, wallet: auth)
                    }
            }
            .padding()
        }
    }

    func onTap(auth: AuthProvider, wallet: WalletConnectProviders? = nil) {
        switch auth {
        case .metamask:
            ethereum.connect(dapp)?.sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    errorMessage = error.localizedDescription
                    print("Connection error: \(errorMessage)")
                case .finished:
                    print("finished metamask")
                }
            }, receiveValue: { result in
                print("Connection result: \(result)")
                if let address = result as? String {
                    userViewModel.fetch(endpoint: .getUser(address))
                }
            }).store(in: &cancellables)
        case .walletconnect:
            if wallet == nil {
                Task(priority: .userInitiated) {
                    try await viewModel.setupInitialState()
                }

                self.presentWalletConnectView = true
            }

            guard let uri = viewModel.uriString, let uriURL = wallet?.uniURL, let url = URL(string: "\(uriURL)://wc?uri=\(uri)") else { return }
            UIApplication.shared.open(url)
        case .snowball:
            print("")
        }
    }
}
