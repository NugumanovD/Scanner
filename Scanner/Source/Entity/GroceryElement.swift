//
//  GroceryElement.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

struct GroceryElement: Decodable {
    let groceryID: Int
    let vegetables: [Vegetable]
}

struct Vegetable: Decodable {
    let vegetableID: Int
    let name, image, code: String

}
