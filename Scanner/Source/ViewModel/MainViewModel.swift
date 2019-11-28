//
//  MainViewModel.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainViewModel: TableViewModelType {
    
    let networkManager = NetworkManager()
    let localStorage = DataBaseManager()
    
    func loadData(completion: @escaping ()-> Void) {
        networkManager.request { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let result = result else { return }
            
            result.forEach({self?.localStorage.addItem(with: $0, count: result.count)})
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return localStorage.allItems().count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellModelType? {
        let vegetable = localStorage.allItems()[indexPath.row]
        return TableViewCellViewModel(vegetable: vegetable)
    }
    
    func allItems() -> [Vegetable] {
        return localStorage.allItems()
    }
}
