//
//  MetaMaskToastOverlay.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI

struct MetaMaskToastOverlay<ToastContent>: View where ToastContent: View {
    let content: ToastContent
    @Binding var isPresented: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    content
                        .frame(width: geometry.size.width * 0.8, height: 8)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color.clear)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isPresented = false
            }
        }
    }
}
