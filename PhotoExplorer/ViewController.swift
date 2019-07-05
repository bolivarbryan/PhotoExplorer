//
//  ViewController.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        API.unsplash(endpoint: .search(query: "kangaroo")).request { photos in
            print(photos)
        }
    }
}

