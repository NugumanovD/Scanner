//
//  MainViewModel.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainViewModel: NSObject, TableViewModelType {
    
    let networkManager = NetworkManager()
    var vegetables = [Vegetable]()
    
    func loadData(completion: @escaping()-> Void ) {
        networkManager.request { (test, error) in
            guard let test = test else { return }
            
            test.forEach({ self.vegetables.append(Vegetable(vegetableID: $0.vegetableID,
                                                            name: $0.name,
                                                            image: $0.image,
                                                            code: $0.code)) })
            completion()
        }
    }
    
    func appendCode(text: String) {
        vegetables.append(Vegetable(vegetableID: 10, name: "", image: "", code: text))
    }
    
    func numberOfRows() -> Int {
        return vegetables.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellModelType? {
        let vegetable = vegetables[indexPath.row]
        return TableViewCellViewModel(vegetable: vegetable)
    }
}
