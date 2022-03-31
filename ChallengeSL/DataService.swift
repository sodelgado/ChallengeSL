//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire



func getCategoryID(textValue: String) {
    let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(textValue)")
  let request = AF.request(categoryURL)
    request.responseDecodable(of: [CategoryPredictor].self) { (response) in
      guard let category = response.value else { return }
        print(category[0].categoryID)
    }

}

//func getHighlights(categoryID: String, completion: @escaping (Result<[CategoryPredictor],NetworkError>)-> Void) {
//    let highlightsURL: String = "https://api.mercadolibre.com/highlights/MLA/category/\(categoryID)"
//        AF.request(highlightsURL, method: .get).responseJSON { response in
//            guard let itemsData = response.data else {
//                completion(.failure(.noData))
//              return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let items = try decoder.decode([CategoryPredictor].self, from: itemsData)
//                DispatchQueue.main.async {
//                    completion(.success(items))
//                    print(items)
//                }
//            } catch {
//                completion(.failure(.badDecodable))
//            }
//        }
//    }

//func getData(q: String,  completion: @escaping (Result<[CategoryPredictor], NetworkError>) -> Void) {
//    let request = AF.request(categoryURL)
//    request.responseDecodable(of: [CategoryPredictor].self) { (response) in
//        guard let categoryData = response.value else {
//            return completion(.failure(.noData))
//        }
//        print(categoryData)
//        return completion(.success(categoryData))
//    }
//}



enum NetworkError: Error {
    case noData
    case badDecodable
}





