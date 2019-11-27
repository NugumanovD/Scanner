//
//  TableViewCellViewModel.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellModelType {
    
    private var vegetable: Vegetable
    
    var vegetableId: Int {
        return vegetable.vegetableID
    }
    
    var name: String {
        return vegetable.name
    }
    
    var image: String {
        return vegetable.image
    }
    
    var code: String {
        return "Code: \(vegetable.code)"
    }
    
    init(vegetable: Vegetable) {
        self.vegetable = vegetable
    }
}
