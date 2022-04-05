//
//  MultigetModel.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 4/4/22.
//

import Foundation
// MARK: - Top20Element
struct Top20Element: Codable {
    let code: Int
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let pictures: [Picture]
    let price: Double
    let id, title: String
}

// MARK: - Picture
struct Picture: Codable {
    let quality, id: String
    let url: String
    let secureURL: String
    let size, maxSize: String

    enum CodingKeys: String, CodingKey {
        case quality, id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
    }
}
