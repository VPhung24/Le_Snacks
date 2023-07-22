//
//  WalletConnectAuthCoordinator.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import SwiftUI
import Auth
import WalletConnectPairing

final class WalletConnectAuthCoordinator {

    let navigationController = UINavigationController()

    private lazy var tabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Auth"
        item.image = UIImage(systemName: "person")
        return item
    }()

    private lazy var authViewController: UIViewController = {
        let viewModel = WalletConnectAuthViewModel()
        let view = WalletConnectAuthView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "DApp"
        return controller
    }()

    func start() {
        navigationController.tabBarItem = tabBarItem
        navigationController.viewControllers = [UIViewController()]

        let metadata = AppMetadata(
            name: "Le Snacks",
            description: "Le Snacks",
            url: "wallet.connect",
            icons: ["https://avatars.githubusercontent.com/u/37784886"])

        Pair.configure(metadata: metadata)
        navigationController.viewControllers = [authViewController]
    }
}
