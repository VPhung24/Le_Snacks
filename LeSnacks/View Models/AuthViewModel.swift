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
import Auth
import WalletConnectPairing
import WalletConnectModal

class AuthViewModel: ObservableObject {
    var user: User?

    // metamask
    @State private var cancellables: Set<AnyCancellable> = []
    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
    private let dapp = Dapp(name: "Le Snacks", url: "https://lesnacks.xyz")

    // wallet connect
    @Published var state: SigningState = .none
    @Published var uriString: String?

    @State private var errorMessage = ""

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
                UIApplication.shared.open(URL(string: "rainbow.me://wc?uri=\(uriString)")!)
            default:
                UIApplication.shared.open(URL(string: "showcase://wc?uri=\(uriString)")!)
            }
        default:
            print("")
        }
    }

    func setupWalletConnectInitialState() {
        Task(priority: .userInitiated) {
            Networking.configure(projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"), socketFactory: WalletConnectDefaultSocketFactory())
            Auth.configure(crypto: WalletConnectDefaultCryptoProvider())

            let metadata = AppMetadata(
                name: "Le Snacks",
                description: "Multi-connect reputation-based restaurant app",
                url: "lesnacks.xyz",
                icons: ["https://imagedelivery.net/_aTEfDRm7z3tKgu9JhfeKA/ffe133c7-910c-4793-e3aa-a564e7430d00/lg"]
            )

            WalletConnectModal.configure(
                projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"),
                metadata: metadata
            )

            Auth.instance.authResponsePublisher.sink { [weak self] (_, result) in
                switch result {
                case .success(let cacao):
                    self?.state = .signed(cacao)
                case .failure(let error):
                    self?.state = .error(error)
                }
            }.store(in: &cancellables)

            state = .none
            uriString = nil
            let uri = try! await Pair.instance.create()
            uriString = uri.absoluteString
            try await Auth.instance.request(.stub(), topic: uri.topic)
        }
    }
}
