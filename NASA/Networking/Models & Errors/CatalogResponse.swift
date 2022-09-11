//
//  Responses.swift
//  NASA
//
//  Created by Elvis Mwenda on 10/09/2022.
//

import Foundation

// MARK: - Welcome
struct CatalogResponse: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [CollectionItem]
    let metadata: Metadata
    let links: [CollectionLink]
}

// MARK: - CollectionItem
struct CollectionItem: Codable, Hashable {
    static func == (lhs: CollectionItem, rhs: CollectionItem) -> Bool {
        return lhs.data == rhs.data && lhs.links == rhs.links && lhs.href == rhs.href
    }
    
    let href: String
    let data: [CollectionItemData]
    let links: [CollectionItemLink]
}

// MARK: - CollectionItemData
struct CollectionItemData: Codable, Hashable {
    var center: String
    var title: String
    var photographer: String?
    var keywords: [String]?
    var nasaID: String
    var mediaType: MediaType
    var dateCreated: String
    var datumDescription: String?
    var description508, secondaryCreator: String?
    var album: [String]?

    enum CodingKeys: String, CodingKey {
        case center, title, photographer, keywords
        case nasaID = "nasa_id"
        case mediaType = "media_type"
        case dateCreated = "date_created"
        case datumDescription = "description"
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
        case album
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: dateCreated) {
            let secondFormatter = DateFormatter()
            secondFormatter.dateFormat = "d MMM, yyyy"
            return secondFormatter.string(from: date)
        }
        return dateCreated
    }
}

enum MediaType: String, Codable, Hashable {
    case image = "image"
    case video = "video"
}

// MARK: - CollectionItemLink
struct CollectionItemLink: Codable, Hashable {
    let href: String
    let rel: String
    let render: MediaType?
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
