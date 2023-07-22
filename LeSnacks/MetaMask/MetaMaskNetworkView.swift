//
//  MetaMaskNetworkView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import metamask_ios_sdk

struct MetaMaskNetworkView: View {
    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
    @Environment(\.presentationMode) var presentationMode
    @State var networkUrl: String = ""

    var body: some View {
        Form {
            Section {
                Text("Current network URL")
                    .modifier(MetaMaskTextCallout())
                TextField("Network url", text: $ethereum.networkUrl)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 32)
                    .modifier(MetaMaskTextCurvature())
                    .disabled(true)
            }

            Section {
                Text("New network URL")
                    .modifier(MetaMaskTextCallout())
                TextField("Network url", text: $networkUrl)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 32)
                    .modifier(MetaMaskTextCurvature())
                    .autocapitalization(.none)
            }

            Section {
                Button {
                    changeNetwork()
                } label: {
                    Text("Update")
                        .modifier(MetaMaskTextButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                }
                .font(.title3)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.blue.grayscale(0.5))
                .modifier(MetaMaskButtonCurvature())
            } footer: {
                Text("You can replace with your local IP address etc")
                    .modifier(MetaMaskTextCaption())
            }
        }
    }

    func changeNetwork() {
        ethereum.networkUrl = networkUrl
        presentationMode.wrappedValue.dismiss()
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        MetaMaskNetworkView()
    }
}
