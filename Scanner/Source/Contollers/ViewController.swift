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
    
    let netWork = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        netWork.request { (grocery, error) in
            print(grocery)
        }
    }
    
}
