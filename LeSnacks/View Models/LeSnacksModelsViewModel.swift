//
//  LeSnacksModelsViewModel.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation

let baseUrl = "https://api.lesnacks.xyz"

public class LeSnacksModelsViewModel<T: Codable>: ObservableObject {
    let apiManager = APIManagerImpl()
    @Published var models: [T] = []
    @Published var user: User?

    func fetch(endpoint: LeSnacksEndpoints, parameters: [String: String] = [:]) {
        let networkRequest = apiManager.networkRequest(baseURL: baseUrl,
                                                       endpoint: endpoint,
                                                       parameters: parameters)

        print(networkRequest)
        apiManager.networkTask(request: networkRequest) { [weak self] (response: Result<[T], Error>) in
            switch response {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.models = models
                    print(models)
                }
            case .failure(let error):
                print("Error fetching: \(error)")
            }
        }
    }

    func fetchUserModel(endpoint: LeSnacksEndpoints) {
        let networkRequest = apiManager.networkRequest(baseURL: baseUrl,
                                                       endpoint: endpoint)

        print(networkRequest)
        apiManager.networkTask(request: networkRequest) { [weak self] (response: Result<User, Error>) in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                    print(user)
                }
            case .failure(let error):
                print("Error fetching: \(error)")
            }
        }
    }
}
