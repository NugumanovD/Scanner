//
//  NetworkManager.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func request(completion: @escaping CompletionHandler) {
        let session = URLSession(configuration: .default)
        
        guard let path = Bundle.main.path(forResource: "ProductsTest", ofType: "json") else {
            completion(nil, .badURL)
            return
            
        }
        let url = URL(fileURLWithPath: path, isDirectory: true)
        
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, .api(error: error))
            }
            
            guard let data = data,
                let json = try? JSONDecoder().decode([Vegetable].self, from: data) else {
                    completion(nil, .incorrectModel)
                    return
            }
            completion(json, nil)
        }
        task.resume()
    }
}


