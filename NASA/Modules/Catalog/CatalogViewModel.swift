//
//  CatalogViewModel.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Combine
import Foundation

final class CatalogViewModel: BaseViewModelType {
    // MARK: Lifecycle

    init(service: NasaService = NasaServiceImpl()) {
        self.service = service
        Publishers.system(
            initial: state,
            reducer: reducer,
            scheduler: RunLoop.current,
            feedback: [whenLoading(), userInput(input: input.eraseToAnyPublisher())]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }

    deinit {
        bag.removeAll()
    }

    // MARK: Internal

    enum Event {
        case onViewDidLoad
        case onLoadNext
        case onError(APIError)
        case onLoaded(CatalogResponse)
    }

    struct State {
        var isLoading = false
        var showMoreLoader = false
        var error: APIError?
        var response: CatalogResponse?
        var maxValue: Int = 10
        var fetchPerPage: Int = 30
        var pageNumber: Int = 1
    }

    @Published var state: State = .init()

    func on(event: Event) {
        input.send(event)
    }

    func reducer(_ state: State, _ event: Event) -> State {
        var newState = state
        switch event {
        case .onViewDidLoad:
            newState.error = nil
            newState.response = nil
            newState.isLoading = true
            newState.showMoreLoader = false
            return newState
        case .onLoadNext:
            guard newState.pageNumber <= newState.maxValue else { return state }
            newState.error = nil
            newState.isLoading = true
            newState.showMoreLoader = true
            newState.pageNumber += 1
            return newState
        case .onError(let error):
            newState.error = error
            newState.isLoading = false
            newState.showMoreLoader = false
            return newState
        case .onLoaded(let mediaResponse):
            newState.error = nil
            newState.isLoading = false
            newState.showMoreLoader = false
            newState.response = mediaResponse
            newState.maxValue = mediaResponse.collection.metadata.totalHits / state.fetchPerPage
            return newState
        }
    }

    // MARK: Private

    private let service: NasaService
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
}

extension CatalogViewModel {
    private func whenLoading() -> Feedback<State, Event> {
        Feedback { [unowned self] (state: State) -> AnyPublisher<Event, Never> in
            guard state.isLoading == true else { return Empty().eraseToAnyPublisher() }
            return self.service.getLists(pageNumber: state.pageNumber)
                .map(Event.onLoaded)
                .catch { error in
                    Just(Event.onError(APIError.withError(error, #file, #line)))
                }.eraseToAnyPublisher()
        }
    }

    private func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
