//
//  WalletConnectDefaultSocketFactory.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation
import Starscream
import WalletConnectRelay

extension WebSocket: WebSocketConnecting { }

struct DefaultSocketFactory: WebSocketFactory {
    func create(with url: URL) -> WebSocketConnecting {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("lesnacks.xyz", forHTTPHeaderField: "Origin")
        return WebSocket(request: urlRequest)
    }
}
