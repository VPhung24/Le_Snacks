//
//  MetaMaskAuthView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI

extension View {
    func toast<ToastContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> ToastContent) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                MetaMaskToastOverlay(content: content(), isPresented: isPresented)
            }
        }
    }
}
