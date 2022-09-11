//
//  Client.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation
import Combine
import Foundation

struct Client {
    /**
        Generic function to return a publisher of type  ***T***  i.e  ***AnyPublisher<T, Error> ***  for unauthenticated API calls.
     
        ### Usage Example: ###
        ````
        let request = URLRequest(url: URL("https://some.com/api")!)
        let publisher = perform(request)
        ````
     
        * Use the `perform(_:)` function to get  anypublisher  from a URLSession.shared.dataTaskPublisher
        * Only ***Decodable*** types are allowed.
    */
    func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
