//
//  Configuration.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/22/23.
//

import Foundation

enum Configuration {
    static func string(for key: String) -> String {
        let value = Bundle.main.object(forInfoDictionaryKey: key) as? String
        print("config \(key): \(value ?? "")")
        return value ?? ""
    }
}
