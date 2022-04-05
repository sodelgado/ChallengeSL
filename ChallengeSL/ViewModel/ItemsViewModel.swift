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
    var refreshData = { () -> () in }
    var itemsList: [Top20Element] = [] {
        didSet {
            refreshData()
        }
    }
    var textValue : String = ""
    var item: String = ""
    
    func getSearchText(searchText: String){
        textValue = searchText
        service.getCategoryID(textValue: searchText, completion: {result in
            switch result {
            case .failure(.noData):
                print("Some error")
            case .success(let categoryID):
                self.setFirstCategoryID2(categoryID: categoryID[0].categoryID)
                print(categoryID)
            }
        })
        print("ViewModel is working")
    }
    
    func setFirstCategoryID2(categoryID: String){
        service.getHighlights(categoryID: categoryID, completion: {result in
            switch result {
            case .failure(.noData):
                print("No data")
            case .success(let highlights):
                let highlightsID = highlights.content.map({ $0.id })
                self.ids = highlightsID.joined(separator: ",")
                self.setWithMultiGet(ids: self.ids)
                print(self.ids)
            }
        })
    }
    
    func setWithMultiGet(ids: String){
        service.multigetItems(ids: ids, completion: {result in
            switch result {
            case .failure(.noData):
                print("No data")
            case .success(let items):
                self.itemsList = items
                print("Multiget is working")
            }
        })
    }
}
