//
//  ItemsViewModel.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 4/4/22.
//

import Foundation

class ItemsViewModel {
    var service = DataService()
    var firstCategoryID: String = ""
    var highlightsID: [String] = []
    var ids: String = ""
    var itemsList: [Top20Element] = []
    var textValue : String = ""
    
    func setFirstCategoryID(data: [CategoryPredictor]){
        firstCategoryID = data[0].categoryID
        print("Aqui \(firstCategoryID)")
        service.getHighlights2(categoryID: firstCategoryID)
    }
    
    func setHighlightsID(data: Highlights?){
        highlightsID = data?.content.map({ $0.id }) ?? []
        ids = highlightsID.joined(separator: ",")
        print(ids)
        service.multigetItems2(ids: ids)
    }
    
    func setItemsList(array: [Top20Element]) -> [Top20Element]{
        itemsList = array
        return itemsList
    }
}
