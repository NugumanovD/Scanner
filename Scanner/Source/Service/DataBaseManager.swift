//
//  DataBaseManager.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/28/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import RealmSwift

class DataBaseManager {

    private var realm: Realm!
    
    init() {
        migrationRealmDataBase()
        do {
            try self.realm = Realm()
        } catch {
            self.realm = nil
        }
    }

    func allItems() -> [Vegetable] {

        return realm.objects(VegetableElement.self).map({ $0.convertToVegetableModel() })
    }

    func addItems(with vegetables: [Vegetable], completion: @escaping() -> Void) {
        
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    for model in vegetables {
                        let backgroundRealm = try Realm()
                        let objects = backgroundRealm.objects(VegetableElement.self)
                        let vegetablesList = VegetableElement()
                        vegetablesList.code = model.code
                        vegetablesList.name = model.name
                        vegetablesList.image = model.image
                        vegetablesList.vegetableID = model.vegetableID
                        if !objects.contains(where: {$0.vegetableID == vegetablesList.vegetableID }) {
                            try? backgroundRealm.write {
                                backgroundRealm.add(vegetablesList)
                            }
                        }
                    }
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateItemCode(idObject: Int, code: String) {
        do {
            let realm = try Realm()
            let objects = realm.objects(VegetableElement.self).filter("vegetableID == %@", idObject).first
            try realm.write {
                objects?.code = code
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func migrationRealmDataBase() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
