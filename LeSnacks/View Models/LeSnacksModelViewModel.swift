//
//  LeSnacksModelViewModel.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/23/23.
//

import Foundation

public class LeSnacksModelViewModel<T: Codable>: ObservableObject {
    let apiManager = APIManagerImpl()
    @Published var model: T?

    func fetch(endpoint: LeSnacksEndpoints, parameters: [String: String] = [:]) {
        let apiManager = APIManagerImpl()

        let networkRequest = apiManager.networkRequest(baseURL: baseUrl,
                                                       endpoint: endpoint,
                                                       parameters: parameters)

        print(networkRequest)
        apiManager.networkTask(request: networkRequest) { (response: Result<T, Error>) in
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.model = model
                    print(model)
                }
            case .failure(let error):
                print("Error fetching: \(error)")
            }
        }
    }
}
