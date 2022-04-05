//
//  DataModel.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 30/3/22.
//

import Foundation

// MARK: - CategoryPredictor
struct CategoryPredictor: Codable {
    let domainID, domainName, categoryID, categoryName: String
    let attributes: [Attribute?]

    enum CodingKeys: String, CodingKey {
        case domainID = "domain_id"
        case domainName = "domain_name"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id, name, valueID, valueName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
    }
}
