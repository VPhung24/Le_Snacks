//
//  MetaMaskTransactionView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import Combine
import metamask_ios_sdk

struct MetaMaskTransactionView: View {
    @ObservedObject var ethereum: Ethereum = MetaMaskSDK.shared.ethereum

    @State private var amount = ""
    @State var result: String = ""
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var to = "0x0000000000000000000000000000000000000000"

    var body: some View {
        Form {
            Section {
                Text("From")
                    .modifier(MetaMaskTextCallout())
                TextField("Enter sender address", text: $ethereum.selectedAddress)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 32)
                    .modifier(MetaMaskTextCurvature())
            }

            Section {
                Text("To")
                    .modifier(MetaMaskTextCallout())
                TextEditor(text: $to)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 32)
                    .modifier(MetaMaskTextCurvature())
            }

            Section {
                Text("Amount")
                    .modifier(MetaMaskTextCallout())
                TextField("Amount", text: $amount)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 32)
                    .modifier(MetaMaskTextCurvature())
            }

            Section {
                Text("Result")
                    .modifier(MetaMaskTextCallout())
                TextEditor(text: $result)
                    .modifier(MetaMaskTextCaption())
                    .frame(minHeight: 40)
                    .modifier(MetaMaskTextCurvature())
            }

            Section {
                Button {
                    sendTransaction()
                } label: {
                    Text("Send transaction")
                        .modifier(MetaMaskTextButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                }
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage)
                    )
                }
                .modifier(MetaMaskButtonStyle())
            }
        }
        .background(Color.blue.grayscale(0.5))
    }

    func sendTransaction() {
        let transaction = MetaMaskTransaction(
            to: to,
            from: ethereum.selectedAddress,
            value: amount
        )

        let transactionRequest = EthereumRequest(
            method: .ethSendTransaction,
            params: [transaction] // eth_sendTransaction rpc call expects an array parameters object
        )

        ethereum.request(transactionRequest)?.sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                errorMessage = error.localizedDescription
                showError = true
                print("Transaction error: \(errorMessage)")
            default: break
            }
        }, receiveValue: { value in
            print("Transaction result: \(value)")
            self.result = value as? String ?? ""
        }).store(in: &cancellables)
    }
}

struct MetaMaskTransaction: CodableData {
    let to: String
    let from: String
    let value: String
    let data: String?

    init(to: String, from: String, value: String, data: String? = nil) {
        self.to = to
        self.from = from
        self.value = value
        self.data = data
    }

    func socketRepresentation() -> NetworkData {
        [
            "to": to,
            "from": from,
            "value": value,
            "data": data
        ]
    }
}

struct MetaMaskTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        MetaMaskTransactionView()
    }
}
