//
//  MockService.swift
//  NASATests
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import Combine
import Foundation
@testable import NASA
final class MockService: NasaService {
    func getLists(pageNumber: Int) -> AnyPublisher<CatalogResponse, Error> {
        let response = Bundle.main.decode(CatalogResponse.self, from: "SampleData.json")
        return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
