//
//  LeSnacksAuthMethods.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import SnowballAssetKit

enum LeSnacksAuth: CaseIterable, Hashable, LoginProviderCellModel {
    case metamask
    case walletconnect
    case snowball
    case none

    var icon: Image {
        switch self {
        case .metamask:
            return SnowballImage(.metamask)
        case .walletconnect:
            return SnowballImage(.walletConnect)
        case .snowball:
            return SnowballImage(.snowball)
        default:
            return SnowballImage(.eth)
        }
    }

    var title: String {
        switch self {
        case .metamask:
            return "MetaMask"
        case .walletconnect:
            return "Wallet Connect"
        case .snowball:
            return "Snowball"
        default:
            return ""
        }
    }
}

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
