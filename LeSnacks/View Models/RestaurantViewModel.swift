//
//  RestaurantViewModel.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation

public class RestaurantViewModel<T: Codable>: ObservableObject {
    let apiManager = APIManagerImpl()
    @Published var models: [T] = []

    init() {
        self.fetch()
    }

    func fetch() {
        let networkRequest = apiManager.networkRequest(baseURL: "https://snacks-dgdkv43unq-no.a.run.app/",
                                                       endpoint: RestaurantEndpoints.all)

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
}

enum RestaurantEndpoints: Endpoint {
    case all

    var path: String {
        switch self {
        case .all:
            return "restaurants"
        }
    }

    var method: Method {
        return .GET
    }
}
