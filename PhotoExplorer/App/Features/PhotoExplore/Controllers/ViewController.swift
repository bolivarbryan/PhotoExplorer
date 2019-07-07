//
//  ViewController.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let operationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()

        let flickrOperation = FetchPhotosFromFlickrOperation()
        let unsplashOperation = FetchPhotosFromUnsplashOperation()
        
        unsplashOperation.completionBlock = {
            print(unsplashOperation.photos)
        }

        unsplashOperation.addDependency(flickrOperation)

        operationQueue.isSuspended = true
        operationQueue.addOperation(flickrOperation)
        operationQueue.addOperation(unsplashOperation)
        operationQueue.isSuspended = false
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
