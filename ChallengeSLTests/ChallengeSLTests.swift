//
//  ChallengeSLTests.swift
//  ChallengeSLTests
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import XCTest
@testable import ChallengeSL

class ChallengeSLTests: XCTestCase {
    let viewModel = ItemsViewModel()
    let element = "iphone"
    let category = "MLA1055"
    var result: String = ""

    func testExample() throws {
        viewModel.service.getCategoryID(textValue: element, completion: {result in
                switch result {
                case .failure(.noData):
                    print("Some error")
                case .success(let categoryID):
                    print(categoryID)
                    self.result = categoryID[0].categoryID
                    XCTAssertEqual(self.result, self.category)
                }
            })
        
    }
}
