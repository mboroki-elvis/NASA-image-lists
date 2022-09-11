//
//  BaseViewModelType.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import SwiftUI

protocol ViewModelType: AnyObject {
    associatedtype Event
    associatedtype State
    func on(event: Event)
    var state: State { get set }
    func reducer(_ state: State, _ event: Event) -> State
}

typealias BaseViewModelType = ViewModelType & ObservableObject
