//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire

//func getCategoryID(textValue: String) {
//    let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
//  let request = AF.request(categoryURL)
//    request.responseDecodable(of: [CategoryPredictor].self) { (response) in
//      guard let category = response.value else { return }
//        print(category[0].categoryID)
        
class DataService {
    let header: HTTPHeaders = [.authorization(bearerToken: "APP_USR-2357420951050600-040416-2b97ea31724d7f2796a20721f4610bdd-251000745")]
    var highlightsID: [String] = []
    var firstCategoryID: String = ""
    var arrayCategory = [CategoryPredictor]()
    var vc = SearchViewController()
    
    func getCategoryID(textValue: String, completion: @escaping (Result<[CategoryPredictor], NetworkError>)-> Void){
        let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
        let request = AF.request(categoryURL, headers: header)
        request.responseDecodable(of: [CategoryPredictor].self) { (response) in
            guard let category = response.value else {
                return completion(.failure(.noData))
            }
            print(category[0].categoryID)
            //        firstCategoryID = category[0].categoryID
            //        print(firstCategoryID)
            return completion(.success(category))
        }
    }
    
    func getCategoryID2(textValue: String){
        let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
        AF.request(categoryURL, headers: header).response { (response) in
            if let data = response.data {
                do{
                    self.arrayCategory = try JSONDecoder().decode([CategoryPredictor].self, from: data)
                    print(self.arrayCategory[0].categoryID)
                } catch let err {
                    print(NetworkError.noData)
                }
            }
        }
    }
    
    func getHighlights(categoryID: String, completion: @escaping (Result<Highlights, NetworkError>) -> Void) {
        let highlightsURL: String = ("https://api.mercadolibre.com/highlights/MLA/category/\(categoryID)")
        let request = AF.request(highlightsURL, headers: header)
        request.responseDecodable(of: Highlights.self) { (response) in
            guard let data = response.value else {
                print("no anda")
                return completion(.failure(.noData))
            }
            print(data)
            //        highlightsID = data.content.map({ $0.id })
            print(self.highlightsID)
            print("jelou")
            return completion(.success(data))
        }
    }
    
    func multiget(array: [String], completion: @escaping (Result<[Top20Element], NetworkError>) -> Void) {
        let top20URL: String = ("https://api.mercadolibre.com/items?ids=\(highlightsID)&attributes=id,price,pictures")
        let request = AF.request(top20URL, headers: header)
        request.responseDecodable(of: [Top20Element].self) { (response) in
            guard let data = response.value else {
                return completion(.failure(.noData))
            }
            print(data)
            print(data[0].body.title)
            return completion(.success(data))
        }
    }
    
    enum NetworkError: Error {
        case noData
    }
}
