//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire

class DataService {
    let header: HTTPHeaders = [.authorization(bearerToken: "APP_USR-2357420951050600-040500-0db7ea1e4349e61e4ec1d4183db28f43-251000745")]
    var highlights: Highlights?
    var arrayItems: [Top20Element] = []
    var viewModel = ItemsViewModel()
    
//    func getCategoryID(textValue: String, completion: @escaping (Result<[CategoryPredictor], NetworkError>)-> Void){
//        let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
//        let request = AF.request(categoryURL)
//        request.responseDecodable(of: [CategoryPredictor].self) { (response) in
//            guard let category = response.value else {
//                return completion(.failure(.noData))
//            }
//            print(category[0].categoryID)
//            viewModel.setFirstCategoryID(data: category)
//            return completion(.success(category))
//        }
//    }
    
    func getCategoryID2(textValue: String){
        let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=mate")
        AF.request(categoryURL, headers: header).response { (response) in
            if let data = response.data {
                do{
                    let arrayCategory = try JSONDecoder().decode([CategoryPredictor].self, from: data)
                    print(arrayCategory[0].categoryID)
                    self.viewModel.setFirstCategoryID(data: arrayCategory)
                } catch let err {
                    print(NetworkError.noData)
                }
            }
        }
    }
    
    
//    func getHighlights(categoryID: String, completion: @escaping (Result<Highlights, NetworkError>) -> Void) {
//        let highlightsURL: String = ("https://api.mercadolibre.com/highlights/MLA/category/\(categoryID)")
//        let request = AF.request(highlightsURL, headers: header)
//        request.responseDecodable(of: Highlights.self) { (response) in
//            guard let data = response.value else {
//                print("no anda")
//                return completion(.failure(.noData))
//            }
//            print(data)
//
//            self.highlightsID = data.content.map({ $0.id })
//            print(self.highlightsID)
//            print("jelou")
//            return completion(.success(data))
//        }
//    }
    func getHighlights2(categoryID: String){
        let highlightsURL: String = ("https://api.mercadolibre.com/highlights/MLA/category/\(categoryID)")
        AF.request(highlightsURL, headers: header).response { (response) in
            if let data = response.data {
                do{
                    self.highlights = try JSONDecoder().decode(Highlights.self, from: data)
                    print(self.highlights ?? nil)
                    self.viewModel.setHighlightsID(data: self.highlights)
                } catch let err {
                    print(NetworkError.noData)
                }
            }
        }
    }

//    func multigetItems(ids: String, completion: @escaping (Result<[Top20Element], NetworkError>) -> Void) {
//        let top20URL: String = ("https://api.mercadolibre.com/items?ids=\(ids)&attributes=id,price,pictures,title")
//        let request = AF.request(top20URL, headers: header)
//        request.responseDecodable(of: [Top20Element].self) { (response) in
//            guard let data = response.value else {
//                return completion(.failure(.noData))
//            }
//            print(data)
//            print(data[0].body.title)
//            return completion(.success(data))
//        }
//    }
func multigetItems2(ids: String){
        let top20URL: String = ("https://api.mercadolibre.com/items?ids=\(ids)&attributes=id,price,pictures,title")
        AF.request(top20URL).response { (response) in
            if let data = response.data {
                do{
                    self.arrayItems = try JSONDecoder().decode([Top20Element].self, from: data)
                    print(self.arrayItems)
                    self.viewModel.setItemsList(array: self.arrayItems)
                } catch let err {
                    print(NetworkError.noData)
                    print("Algo no funca")
                }
            }
        }
    }
    enum NetworkError: Error {
        case noData
    }
}
