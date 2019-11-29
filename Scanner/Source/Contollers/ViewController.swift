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
    
    // MARK: - Private Outlet 
    
    @IBOutlet private var tableView: UITableView!
    
    var capturedId: Int?
    
    // MARK: - Public Properties
    
    private var mainViewModel: TableViewModelType?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel = MainViewModel()
        mainViewModel?.loadData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    // MARK: - Public Function
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension ViewController: UITableViewDelegate {
    
    // MARK: - Public Function
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = mainViewModel else { return }
        let item = viewModel.cellViewModel(forIndexPath: indexPath)
        self.capturedId = item?.vegetableId
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let scannerVC = segue.destination as? ScannerViewController {
            if segue.identifier == "detailSegue" {
                scannerVC.capturedId = capturedId
            }
        }
    }
}
