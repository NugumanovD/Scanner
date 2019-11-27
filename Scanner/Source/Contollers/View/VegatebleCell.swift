//
//  VegatebleCell.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/26/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet private var imageProduct: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var codeLabel: UILabel!
    
    weak var viewModel: TableViewCellModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            imageProduct.image = UIImage(named: viewModel.image)
            nameLabel.text = viewModel.name
            codeLabel.text = viewModel.code
        }
    }
    
    func configureImage(to image: String) {
        imageProduct.image = UIImage(named: image)
        imageProduct.contentMode = .scaleAspectFit
    }
    
    func configureName(to name: String) {
        nameLabel.text = name.capitalized
    }
    
    func configureCode(to code: String) {
        codeLabel.text = code
    }
    
}
