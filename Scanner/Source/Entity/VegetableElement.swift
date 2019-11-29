//
//  VegetableElement.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Realm
import RealmSwift

class VegetableElement: Object {
    @objc dynamic var vegetableID: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var code: String = ""
}

extension VegetableElement {
    
    // MARK: - Public Function
    
    func convertToVegetableModel() -> Vegetable {
        return Vegetable(vegetableID: vegetableID, name: name, image: image, code: code)
    }
}
