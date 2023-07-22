//
//  WalletConnectWallets.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI
import SnowballAssetKit

enum Wallets: String, CaseIterable, LoginProviderCellModel {
    case rainbow
    case trust

    var icon: Image {
        switch self {
        case .rainbow:
            // to do add icon
            return SnowballImage(.ledger)
        case .trust:
            return SnowballImage(.trust)
        }
    }

    var title: String {
        return self.rawValue.capitalized(with: .current)
    }
}
