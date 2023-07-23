//
//  WalletConnectProviders.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import SwiftUI
import SnowballAssetKit

enum WalletConnectProviders: String, CaseIterable, LoginProviderProtocol {
    case rainbow
    case trust

    var icon: Image {
        switch self {
        case .rainbow:
            return SnowballImage(.eth)
        case .trust:
            return SnowballImage(.trust)
        }
    }

    var title: String {
        return self.rawValue.uppercased(with: .current)
    }

    var uniURL: String {
        switch self {
        case .rainbow:
            return "rnbwapp"
        case .trust:
            return "trust"
        }
    }
}
