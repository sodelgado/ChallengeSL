//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire

class DataService {
    let header: HTTPHeaders = [.authorization(bearerToken: "APP_USR-2357420951050600-040510-17d4758efc0c4958a8fb48a2942876a7-251000745")]
    
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
    func multigetItems(ids: String, completion: @escaping (Result<[Top20Element], NetworkError>) -> Void) {
        let top20URL: String = ("https://api.mercadolibre.com/items?ids=\(ids)&attributes=id,price,pictures,title")
        let request = AF.request(top20URL, headers: header)
        request.responseDecodable(of: [Top20Element].self) { (response) in
            guard let data = response.value else {
                return completion(.failure(.noData))
            }
            print(data)
            print(data[0].body.title)
            print("Bien, hasta ahi no hay problema")
            return completion(.success(data))
        }
    }
    
    func getDetailsItem(id: String, completion: @escaping (Result<[Top20Element], NetworkError>) -> Void) {
        let detailsURL: String = "https://api.mercadolibre.com/items/\(id)"
        let request = AF.request(detailsURL, headers: header)
        request.responseDecodable(of: [Top20Element].self) { (response) in
            guard let data = response.value else {
                return completion(.failure(.noData))
            }
            print(data)
            print(data[0].body.price)
            return completion(.success(data))
        }
    }
    enum NetworkError: Error {
        case noData
    }
}
