//
//  LeSnacksApp.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import Starscream
import WalletConnectRelay
import WalletConnectNetworking
import WalletConnectSigner
import WalletConnectModal
import Auth
import Foundation
import Web3
import CryptoSwift
import HDWalletKit

@main
struct LeSnacksApp: App {
    init() {
        Networking.configure(projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"), socketFactory: DefaultSocketFactory())
        Auth.configure(crypto: DefaultCryptoProvider())

        let metadata = AppMetadata(
            name: "Le Snacks",
            description: "Snackssss",
            url: "wallet.connect",
            icons: ["https://avatars.githubusercontent.com/u/37784886"]
        )

        WalletConnectModal.configure(
            projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"),
            metadata: metadata
        )
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
