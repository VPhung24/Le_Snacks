//
//  LeSnacksApp.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import Combine
import metamask_ios_sdk

@main
struct LeSnacksApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var userViewModel = LeSnacksModelViewModel<User>()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if userViewModel.model != nil {
                    HomeView(address: userViewModel.model?.walletAddress ?? "")
                } else {
                    LoginView(userViewModel: userViewModel)
                }
            }
        }
    }
}
