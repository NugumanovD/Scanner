//
//  TableViewModelType.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

protocol TableViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellModelType?
    func loadData(completion: @escaping()-> Void)
    func allItems() -> [Vegetable]
    func updateItemCode(idObject: Int, code: String, completion: @escaping() -> Void)
}

