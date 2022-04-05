//
//  HighlightsModel.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 4/4/22.
//

import Foundation
// MARK: - Highlights
struct Highlights: Codable {
    let queryData: QueryData
    let content: [Content]

    enum CodingKeys: String, CodingKey {
        case queryData = "query_data"
        case content
    }
}

// MARK: - Content
struct Content: Codable {
    let id: String
    let position: Int
    let type: Item
}

enum Item: String, Codable {
    case item = "ITEM"
}

// MARK: - QueryData
struct QueryData: Codable {
    let highlightType, criteria, id: String

    enum CodingKeys: String, CodingKey {
        case highlightType = "highlight_type"
        case criteria, id
    }
}
