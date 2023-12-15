//
//  FindMeADrink.swift
//  RestaurantMenu
//
//  Created by user237116 on 12/14/23.
//

import Foundation
import UIKit

final class FindMeADrinkApiService : NSObject{
    
    static let API_service = FindMeADrinkApiService()
    
    private override init() {
        
    }
    
    
    
    func fetchAll(completion: @escaping (DrinkResponse?) -> Void) {
        print("In fetch all drinks")
        fetchData(url: "https://www.thecocktaildb.com/api/json/v1/1/random.php", model: DrinkResponse.self) { data in
            print("fetch data")
            print(data)
            let issues: DrinkResponse = data
            completion(issues)
        } failure: { error in
            print(error)
        }
    }

    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping (T) -> (), failure: @escaping (Error) -> ()) {
        guard let url = URL(string: url) else { return }

        var request = URLRequest(url: url)
        request.addValue("Basic", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }
        .resume()
    }
}
