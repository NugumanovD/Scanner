//
//  NetworkManager.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

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

class DataBaseManager {

    private var realm: Realm!
    init() {
//        migrationRealmDataBase()
        do {
            try self.realm = Realm()
        } catch {
            self.realm = nil
        }
    }

    func allItems() -> [Vegetable] {
        
        return realm.objects(VegetableElement.self).map({ $0.convertToVegetableModel() })
    }

    func addItem(with model: Vegetable) {
        DispatchQueue.global().async {
            autoreleasepool {
                let vegetablesList = VegetableElement()
                vegetablesList.code = model.code
                vegetablesList.name = model.name
                vegetablesList.image = model.image
                vegetablesList.vegetableID = model.vegetableID
                
                do {
                    let backgroundRealm = try Realm()
                    if self.realm.isEmpty {
                        try backgroundRealm.write {
                            backgroundRealm.add(vegetablesList)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func migrationRealmDataBase() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
