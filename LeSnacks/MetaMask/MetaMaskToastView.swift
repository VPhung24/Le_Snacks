//
//  MetaMaskToastView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI

struct MetaMaskToastView: View {
    let message: String

    var body: some View {
        VStack {
            Text(message)
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct MetaMaskToastView_Previews: PreviewProvider {
    static var previews: some View {
        MetaMaskToastView(message: "Test message")
    }
}
