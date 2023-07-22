//
//  MetaMaskButtonStyle.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI

struct MetaMaskButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.blue.grayscale(0.5))
            .modifier(MetaMaskButtonCurvature())
    }
}
