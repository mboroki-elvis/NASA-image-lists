//
//  AppEnvironment.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation

enum AppEnvironment {
    static let baseURLString: String = {
        guard let base = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("Not found")
        }
        return base
    }()
}
