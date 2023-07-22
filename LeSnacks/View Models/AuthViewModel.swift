//
//  AuthViewModel.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation
import SwiftUI
import Combine
import metamask_ios_sdk

class AuthViewModel: ObservableObject {
    var user: User?
    
    // metamask
    @State private var cancellables: Set<AnyCancellable> = []
    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
    private let dapp = Dapp(name: "Le Snacks", url: "https://lesnacks.xyz")
    
    // wallet connect
    @ObservedObject var walletConnectViewModel = WalletConnectAuthViewModel()
    
    @State private var errorMessage = ""
    
    func setupWalletConnectInitialState() {
        Task(priority: .userInitiated) {
            try await walletConnectViewModel.setupInitialState()
        }
    }
    
    func authenticate(for provider: AuthMethods, wallet: Wallets? = nil) {
        switch provider {
        case .metamask:
            ethereum.connect(dapp)?.sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.errorMessage = error.localizedDescription
                    print("Connection error: \(String(describing: self?.errorMessage))")
                case .finished:
                    print("metamask connection finished")
                }
            }, receiveValue: { [weak self] result in
                print("Connection success: \(result)")
                if let self = self {
                    self.user = User(address: self.ethereum.selectedAddress)
                    print(self.ethereum.selectedAddress)
                }
            })
            .store(in: &cancellables)
        case .walletconnect:
            print("hello")
            switch wallet {
            case .rainbow:
                UIApplication.shared.open(URL(string: "rainbow.me://wc?uri=\(walletConnectViewModel.uriString)")!)
            default:
                UIApplication.shared.open(URL(string: "showcase://wc?uri=\(walletConnectViewModel.uriString)")!)
            }
        default:
            print("")
        }
    }
}
