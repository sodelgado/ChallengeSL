//
//  DataService.swift
//  ChallengeSL
//
//  Created by Sofia Belen Delgado Gonzalez on 29/3/22.
//

import Foundation
import Alamofire

let categoryURL: String = ("https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\("iphone")")

func getCategory() {
  let request = AF.request(categoryURL)
    request.responseDecodable(of: [CategoryPredictor].self) { (response) in
      guard let category = response.value else { return }
        print(category)
    }

}

func getData(q: String,  completion: @escaping (Result<[CategoryPredictor], NetworkError>) -> Void) {
    let request = AF.request(categoryURL)
    request.responseDecodable(of: [CategoryPredictor].self) { (response) in
        guard let categoryData = response.value else {
            return completion(.failure(.noData))
        }
        print(categoryData)
        return completion(.success(categoryData))
    }
}

func getItemsFromServer(completion: @escaping (Result<[CategoryPredictor],NetworkError>)-> Void) {
        AF.request(categoryURL, method: .get).responseJSON { response in
            guard let itemsData = response.data else {
                completion(.failure(.noData))
              return
            }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([CategoryPredictor].self, from: itemsData)
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            } catch {
                completion(.failure(.badDecodable))
            }
        }
    }
enum NetworkError: Error {
    case noData
    case badDecodable
}





