//
//  NASATests.swift
//  NASATests
//
//  Created by Elvis Mwenda on 10/09/2022.
//

@testable import NASA
import XCTest

class CatalogViewModelTests: XCTestCase {
    func testonViewDidLoad() throws {
        let expectation = XCTestExpectation(description: "Test on ViewDidLoad")
        let viewModel = CatalogViewModel(service: MockService())
        viewModel.on(event: .onViewDidLoad)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        let state = viewModel.state
        XCTAssertTrue(!state.isLoading && !state.showMoreLoader && state.response != nil && state.error == nil)
    }

    func testonLoadNext() throws {
        let expectation = XCTestExpectation(description: "Test on LoadNext")
        let viewModel = CatalogViewModel(service: MockService())
        viewModel.on(event: .onLoadNext)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        let state = viewModel.state
        XCTAssertTrue(!state.isLoading && !state.showMoreLoader && state.response != nil)
    }
}
