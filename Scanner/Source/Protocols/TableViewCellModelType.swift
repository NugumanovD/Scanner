//
//  TableViewCellModelType.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

protocol TableViewCellModelType: class {
    var vegetableId: Int { get }
    var name: String { get }
    var image: String { get }
    var code: String { get }
}
