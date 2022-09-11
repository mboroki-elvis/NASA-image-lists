//
//  NasaService.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Combine
import Foundation

protocol NasaService {
    func getLists(pageNumber: Int) -> AnyPublisher<CatalogResponse, Error>
}

final class NasaServiceImpl: NasaService {
    // MARK: Internal

    func getLists(pageNumber: Int) -> AnyPublisher<CatalogResponse, Error> {
        guard let request = URLComponents(string: baseURL + "/search?q=\("%22%22")")?
            .addingQueryItem("page", "\(pageNumber)")
            .request
        else { return Fail(error: APIError.empty).eraseToAnyPublisher() }
        return client.perform(request)
    }

    // MARK: Private

    private let baseURL = AppEnvironment.baseURLString
    private let client = Client()
}
