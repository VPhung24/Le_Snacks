//
//  AuthMethods.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import SnowballAssetKit

enum AuthMethods: CaseIterable, Hashable, LoginProviderCellModel {
    case metamask
    case walletconnect
    case snowball

    var icon: Image {
        switch self {
        case .metamask:
            return SnowballImage(.metamask)
        case .walletconnect:
            return SnowballImage(.walletConnect)
        case .snowball:
            return SnowballImage(.snowball)
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
        }
    }
}
