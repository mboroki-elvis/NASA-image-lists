//
//  PaginationType.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//
import Foundation
public protocol PaginationType {
    var maxValue: Int { get }
    var fetchPerPage: Int { get }
//    var pageNumber: BehaviorRelay<Int> { get }
//    var pageNumberObservable: Observable<Int> { get }
}
