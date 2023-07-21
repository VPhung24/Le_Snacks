//
//  LoginProviders.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import Foundation
import SnowballAssetKit

struct LoginProvider {
    let icon: SnowballIcon
    
    public init(_ provider: SnowballIcon) {
        self.icon = provider
    }
    
    var title: String {
        return icon.rawValue
    }
}
