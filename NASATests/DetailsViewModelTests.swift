//
//  DetailsViewModelTests.swift
//  NASATests
//
//  Created by Elvis Mwenda on 11/09/2022.
//

@testable import NASA
import XCTest

class DetailsViewModelTests: XCTestCase {
    func testonViewDidLoad() throws {
        let expectation = XCTestExpectation(description: "Test on ViewDidLoad")
        let response = Bundle.main.decode(CatalogResponse.self, from: "SampleData.json")
        guard let model = response.collection.items.first else {
            XCTFail()
            return
        }
        let viewModel = DetailsViewModel(model: model)
        viewModel.on(event: .onViewDidLoad)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        switch  viewModel.state {
            
        case .idle:
            XCTAssertTrue(false)
        case .loaded(let model):
            XCTAssertTrue(!model.links.isEmpty)
        }
    }
    
    func testonLoadItem() throws {
        let expectation = XCTestExpectation(description: "Test on ViewDidLoad")
        let response = Bundle.main.decode(CatalogResponse.self, from: "SampleData.json")
        guard let model = response.collection.items.first else {
            XCTFail()
            return
        }
        let viewModel = DetailsViewModel(model: model)
        viewModel.on(event: .onLoad(model))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        switch  viewModel.state {
            
        case .idle:
            XCTAssertTrue(false)
        case .loaded(let model):
            XCTAssertTrue(!model.links.isEmpty)
        }
    }
}
