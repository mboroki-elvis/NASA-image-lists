//
//  URLComponents+Extensions.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation

extension URLComponents {
    func addingQueryItem(_ name: String, _ value: String) -> URLComponents {
        var copy = self
        copy.queryItems = (copy.queryItems ?? []) + [URLQueryItem(name: name, value: value)]
        return copy
    }

    var request: URLRequest? {
        url.map { URLRequest(url: $0) }
    }
}

extension URLRequest {
    func withHeaders(key: String, value: String) -> URLRequest {
        var copy = self
        copy.addValue(value, forHTTPHeaderField: key)
        return copy
    }

    func post() -> URLRequest {
        var copy = self
        copy.httpMethod = "POST"
        return copy
    }

    func get() -> URLRequest {
        var copy = self
        copy.httpMethod = "GET"
        return copy
    }
}
