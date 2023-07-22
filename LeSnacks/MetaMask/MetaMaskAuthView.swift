//
//  MetaMaskAuthView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import Combine
import metamask_ios_sdk

extension Notification.Name {
    static let Event = Notification.Name("event")
    static let Connection = Notification.Name("connection")
}

struct MetaMaskAuthView: View {
    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
    @State private var cancellables: Set<AnyCancellable> = []

    private let dapp = Dapp(name: "Le Snacks", url: "https://lesnacks.xyz")

    @State private var connected: Bool = false
    @State private var status: String = "Offline"

    @State private var errorMessage = ""
    @State private var showError = false

    @State private var showProgressView = false
    @State private var showToast = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    Group {
                        HStack {
                            Text("Status")
                                .bold()
                                .modifier(MetaMaskTextCallout())
                            Spacer()
                            Text(status)
                                .modifier(MetaMaskTextCaption())
                        }

                        HStack {
                            Text("Chain ID")
                                .bold()
                                .modifier(MetaMaskTextCallout())
                            Spacer()
                            Text(ethereum.chainId)
                                .modifier(MetaMaskTextCaption())
                        }

                        HStack {
                            Text("Account")
                                .bold()
                                .modifier(MetaMaskTextCallout())
                            Spacer()
                            Text(ethereum.selectedAddress)
                                .modifier(MetaMaskTextCaption())
                        }
                    }
                }

                if !ethereum.selectedAddress.isEmpty {
                    Section {
                        Group {
                            NavigationLink("Sign") {
                                MetaMaskSignView()
                            }

                            NavigationLink("Transact") {
                                MetaMaskTransactionView()
                            }

                            NavigationLink("Switch chain") {
                                SwitchChainView()
                            }

                            Button {
                                ethereum.clearSession()
                                showToast = true
                            } label: {
                                Text("Clear Session")
                                    .modifier(MetaMaskTextButton())
                                    .frame(maxWidth: .infinity, maxHeight: 32)
                            }
                            .toast(isPresented: $showToast) {
                                MetaMaskToastView(message: "Session cleared")
                            }
                            .modifier(MetaMaskButtonStyle())
                        }
                    }
                }

                if ethereum.selectedAddress.isEmpty {
                    Section {
                        ZStack {
                            Button {
                                showProgressView = true

                                ethereum.connect(dapp)?.sink(receiveCompletion: { completion in
                                    switch completion {
                                    case let .failure(error):
                                        showProgressView = false
                                        errorMessage = error.localizedDescription
                                        showError = true
                                        print("Connection error: \(errorMessage)")
                                    case .finished:
                                        print("metamask connection finished")
                                    }
                                }, receiveValue: { result in
                                    showProgressView = false
                                    print("Connection result: \(result)")
                                }).store(in: &cancellables)
                            } label: {
                                Text("Connect to MetaMask")
                                    .modifier(MetaMaskTextButton())
                                    .frame(maxWidth: .infinity, maxHeight: 32)
                            }
                            .modifier(MetaMaskButtonStyle())

                            if showProgressView && !ethereum.connected {
                                ProgressView()
                                    .scaleEffect(1.5, anchor: .center)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            }
                        }
                        .alert(isPresented: $showError) {
                            Alert(
                                title: Text("Error"),
                                message: Text(errorMessage)
                            )
                        }
                    } footer: {
                        Text("This will open the MetaMask app. Please sign in and accept the connection prompt.")
                            .modifier(MetaMaskTextCaption())
                    }
                }
            }
            .font(.body)
            .onReceive(NotificationCenter.default.publisher(for: .Connection)) { notification in
                status = notification.userInfo?["value"] as? String ?? "Offline"
            }
            .navigationTitle("Le Snacks")
        }
    }
}

struct MetaMaskAuthView_Previews: PreviewProvider {
    static var previews: some View {
        MetaMaskAuthView()
    }
}
