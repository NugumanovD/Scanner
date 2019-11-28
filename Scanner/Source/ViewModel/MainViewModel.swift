//
//  MainViewModel.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

class MainViewModel: NSObject, TableViewModelType {
    
    let networkManager = NetworkManager()
    let localStorage = DataBaseManager()
    var vegetables = [Vegetable]()
    
    
    func loadData(completion: @escaping()-> Void) {
        networkManager.request { (result, error) in
            guard let result = result else { return }
            
//            result.forEach({ self.vegetables.append(Vegetable(vegetableID: $0.vegetableID,
//                                                            name: $0.name,
//                                                            image: $0.image,
//                                                            code: $0.code))
//            })
            
            result.forEach({self.localStorage.addItem(with: $0)})
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return localStorage.allItems().count
//        return vegetables.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellModelType? {
//        let vegetable = vegetables[indexPath.row]
        let vegetable = localStorage.allItems()[indexPath.row]
        return TableViewCellViewModel(vegetable: vegetable)
    }
    
    func allItems() -> [Vegetable] {
        return localStorage.allItems()
    }
}
