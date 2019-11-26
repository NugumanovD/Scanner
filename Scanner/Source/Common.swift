//
//  Common.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case badURL
    case api(error: Swift.Error)
    case incorrectModel
}
