//
//  DetailsViewModel.swift
//  NASA
//
//  Created by Elvis Mwenda on 11/09/2022.
//

import Combine
import Foundation

final class DetailsViewModel: BaseViewModelType {
    // MARK: Lifecycle

    init(model: CollectionItem) {
        Publishers.system(
            initial: state,
            reducer: reducer,
            scheduler: RunLoop.main,
            feedback: [userInput(input: input.eraseToAnyPublisher())]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.on(event: .onLoad(model))
        }
    }

    // MARK: Internal

    enum State {
        case idle
        case loaded(CollectionItem)
    }

    enum Event {
        case onViewDidLoad
        case onLoad(CollectionItem)
    }

    @Published var state: State = .idle

    func on(event: Event) {
        input.send(event)
    }

    func reducer(_ state: State, _ event: Event) -> State {
        switch event {
        case .onViewDidLoad:
            return .idle
        case .onLoad(let catalogResponse):
            return .loaded(catalogResponse)
        }
    }

    // MARK: Private

    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
}

extension DetailsViewModel {
    private func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
