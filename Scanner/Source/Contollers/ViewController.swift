//
//  ViewController.swift
//  Scanner
//
//  Created by Nugumanov Dmitriy on 11/25/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var mainViewModel: TableViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel = MainViewModel()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tableViewIdentifier , for: indexPath) as? TableViewCell
        
        guard let tableViewCell = cell, let mainViewModel = mainViewModel else { return UITableViewCell() }
        
        let cellViewModel = mainViewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = mainViewModel else { return }
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = mainViewModel else { return }
        
        if identifier == "detailSegue" {
//            if ler scannerViewController =
        }
    }
}
