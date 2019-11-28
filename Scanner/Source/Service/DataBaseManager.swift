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

    func addItem(with model: Vegetable, count: Int) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    let backgroundRealm = try Realm()
                    let vegetablesList = VegetableElement()
                    vegetablesList.code = model.code
                    vegetablesList.name = model.name
                    vegetablesList.image = model.image
                    vegetablesList.vegetableID = model.vegetableID
                    let objects = backgroundRealm.objects(VegetableElement.self).count
                    if objects < count {
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
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
