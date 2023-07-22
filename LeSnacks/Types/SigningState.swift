//
//  SigningState.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation
import WalletConnectUtils

enum SigningState {
    case none
    case signed(Cacao)
    case error(Error)
}
