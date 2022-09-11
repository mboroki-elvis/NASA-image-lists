//
//  Publisher+Extension.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Combine
import Foundation
import SwiftUI

extension Publishers {
    static func system<State, Event, Scheduler: Combine.Scheduler>(
        initial: State,
        reducer: @escaping (State, Event) -> State,
        scheduler: Scheduler,
        feedback: [Feedback<State, Event>]
    ) -> AnyPublisher<State, Never> {
        let state = CurrentValueSubject<State, Never>(initial)
        let events = feedback.map { $0.run(state.eraseToAnyPublisher()) }
        return Deferred {
            Publishers
                .MergeMany(events)
                .receive(on: scheduler)
                .scan(initial, reducer)
                .handleEvents(receiveOutput: state.send)
                .receive(on: scheduler)
                .prepend(initial)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
