//
//  NetworkManager.swift
//  Nutrition Tracker
//
//  Created by Jared Ryan on 7/18/24.
//

import Foundation

struct NutritionalData: Codable {
    let food_name: String
    let brand_name: String
    let nf_calories: Double
}

class NetworkManager {
    func fetchNutritionalData(for barcode: String, completion: @escaping (NutritionalData?) -> Void) {
        let appId = "a6164713" // Your Application ID
        let appKey = "d64f1704ba54020489756c0a91e22c58" // Your Application Key
        let urlString = "https://trackapi.nutritionix.com/v2/search/item?upc=\(barcode)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        print("Request URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(appId, forHTTPHeaderField: "x-app-id")
        request.setValue(appKey, forHTTPHeaderField: "x-app-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("HTTP Request Failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let responseJSON = try JSONDecoder().decode([String: [NutritionalData]].self, from: data)
                if let nutritionalData = responseJSON["foods"]?.first {
                    completion(nutritionalData)
                } else {
                    print("No food data found")
                    completion(nil)
                }
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
