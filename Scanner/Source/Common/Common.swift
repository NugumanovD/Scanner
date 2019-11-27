//
//  Common.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

typealias CompletionHandler = ([Vegetable]?, Error?) -> Void

enum Error: Swift.Error {
    case badURL
    case api(error: Swift.Error)
    case incorrectModel
}

enum Cell {
    static let collectionCell = "collectionViewCell"
    static let tableViewIdentifier = "cell"
}
