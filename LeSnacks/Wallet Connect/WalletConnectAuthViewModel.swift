//
//  WalletConnectAuthViewModel.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import UIKit
import Combine
import Auth
import WalletConnectPairing
import WalletConnectModal

final class WalletConnectAuthViewModel: ObservableObject {

    enum SigningState {
        case none
        case signed(Cacao)
        case error(Error)
    }

    private var disposeBag = Set<AnyCancellable>()

    @Published var state: SigningState = .none
    @Published var uriString: String?

    var qrImage: UIImage? {
        return uriString.map { QRCodeGenerator.generateQRCode(from: $0) }
    }

    init() {
        setupSubscriptions()
    }

    @MainActor
    func setupInitialState() async throws {
        state = .none
        uriString = nil
        let uri = try! await Pair.instance.create()
        uriString = uri.absoluteString
        try await Auth.instance.request(.stub(), topic: uri.topic)
    }

    func copyDidPressed() {
        UIPasteboard.general.string = uriString
    }

    func walletDidPressed() {

    }

    func deeplinkPressed() {
        guard let uri = uriString else { return }
        UIApplication.shared.open(URL(string: "showcase://wc?uri=\(uri)")!)
    }
}

private extension WalletConnectAuthViewModel {

    func setupSubscriptions() {
        Networking.configure(projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"), socketFactory: DefaultSocketFactory())
        Auth.configure(crypto: DefaultCryptoProvider())

        let metadata = AppMetadata(
            name: "Le Snacks",
            description: "Snackssss",
            url: "lesnacks.xyz",
            icons: ["https://avatars.githubusercontent.com/u/37784886"]
        )

        WalletConnectModal.configure(
            projectId: Configuration.string(for: "WALLET_CONNECT_PROJECT_ID"),
            metadata: metadata
        )

        Auth.instance.authResponsePublisher.sink { [weak self] (_, result) in
            switch result {
            case .success(let cacao):
                DispatchQueue.main.async {
                    self?.state = .signed(cacao)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .error(error)
                }
            }
        }.store(in: &disposeBag)
    }
}

private extension RequestParams {
    static func stub(
        domain: String = "service.invalid",
        chainId: String = "eip155:1",
        nonce: String = "32891756",
        aud: String = "https://service.invalid/login",
        nbf: String? = nil,
        exp: String? = nil,
        statement: String? = "I accept the ServiceOrg Terms of Service: https://service.invalid/tos",
        requestId: String? = nil,
        resources: [String]? = ["ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/", "https://example.com/my-web2-claim.json"]
    ) -> RequestParams {
        return RequestParams(
            domain: domain,
            chainId: chainId,
            nonce: nonce,
            aud: aud,
            nbf: nbf,
            exp: exp,
            statement: statement,
            requestId: requestId,
            resources: resources
        )
    }
}
