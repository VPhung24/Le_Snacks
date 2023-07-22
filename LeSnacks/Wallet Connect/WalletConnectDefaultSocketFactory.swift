//
//  WalletConnectDefaultSocketFactory.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation
import Starscream
import WalletConnectRelay

// todo: walletconnect websocket
class WalletConnectWebSocket: WebSocketConnecting {
    var request: URLRequest = .init(url: URL(string: "wss://relay.walletconnect.com")!)
    var isConnected: Bool = false

    init(request: URLRequest) {
        self.request = request
    }

    var onConnect: (() -> Void)?
    var onDisconnect: ((Error?) -> Void)?
    var onText: ((String) -> Void)?

    func connect() {
        print("websocket connected")
        isConnected = true
    }

    func disconnect() {
        print("websocket disconnected")
        isConnected = false
    }

    func write(string: String, completion: (() -> Void)?) {
        print("websocket write \(string)")
        completion?()
    }
}

struct WalletConnectDefaultSocketFactory: WebSocketFactory {
    func create(with url: URL) -> WebSocketConnecting {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("lesnacks.xyz", forHTTPHeaderField: "Origin")
        return WalletConnectWebSocket(request: urlRequest)
    }
}
