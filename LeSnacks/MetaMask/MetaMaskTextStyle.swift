//
//  MetaMaskTextStyle.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI

struct MetaMaskTextCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.caption, design: .rounded))
            .foregroundColor(.black)
    }
}

struct MetaMaskTextCallout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.black)
    }
}

struct MetaMaskTextCalloutLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.gray)
    }
}

struct MetaMaskTextButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
    }
}
