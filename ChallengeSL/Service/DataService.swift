//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire

//MARK: Class to request data
class DataService {
    let header: HTTPHeaders = [.authorization(bearerToken: "APP_USR-2357420951050600-040515-0bc9979a37b62d9ad7fcd157ef04876d-251000745")]
//   MARK: function to get categoryID
    func getCategoryID(textValue: String, completion: @escaping (Result<[CategoryPredictor], NetworkError>)-> Void){
        let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
        let request = AF.request(categoryURL)
        request.responseDecodable(of: [CategoryPredictor].self) { (response) in
            guard let category = response.value else {
                return completion(.failure(.noData))
            }
            print(category[0].categoryID)
            return completion(.success(category))
        }
    }
//    MARK: function to get Highlights for a specific category
    func getHighlights(categoryID: String, completion: @escaping (Result<Highlights, NetworkError>) -> Void) {
        let highlightsURL: String = ("https://api.mercadolibre.com/highlights/MLA/category/\(categoryID)")
        let request = AF.request(highlightsURL, headers: header)
        request.responseDecodable(of: Highlights.self) { (response) in
            guard let data = response.value else {
                print("no anda")
                return completion(.failure(.noData))
            }
            print(data)
            print("jelou")
            return completion(.success(data))
        }
    }
// MARK: function to bring up to 20 items
    func multigetItems(ids: String, completion: @escaping (Result<[Top20Element], NetworkError>) -> Void) {
        let top20URL: String = ("https://api.mercadolibre.com/items?ids=\(ids)&attributes=id,price,pictures,title")
        let request = AF.request(top20URL, headers: header)
        request.responseDecodable(of: [Top20Element].self) { (response) in
            guard let data = response.value else {
                return completion(.failure(.noData))
            }
            print(data)
            print("First title: \(data[0].body.title)")
            return completion(.success(data))
        }
    }
    enum NetworkError: Error {
        case noData
    }
}
