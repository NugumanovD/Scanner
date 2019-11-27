//
//  MainViewModel.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainViewModel: NSObject, TableViewModelType {
    
    
    
    var vegetables: [Vegetable] = [
        Vegetable(vegetableID: 1, name: "Apple", image: "",code: ""),
        Vegetable(vegetableID: 2, name: "Pinapple", image: "", code: ""),
        Vegetable(vegetableID: 3, name: "Cherry", image: "", code: "")
    ]
    
    func numberOfRows() -> Int {
        return vegetables.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellModelType? {
        let vegetable = vegetables[indexPath.row]
        return TableViewCellViewModel(vegetable: vegetable)
    }
    
    
//     let groceriesModel: MainModel
//    
//    init(model: MainModel) {
//        self.groceriesModel = model
//    }
//    
//    func getGroceries(completion: @escaping( [GroceryElement?]) -> Void) {
//        groceriesModel.getVegetables { (groceries, error) in
//            guard let groceriesResult = groceries else { return }
//            completion(groceriesResult)
//        }
//    }
}
