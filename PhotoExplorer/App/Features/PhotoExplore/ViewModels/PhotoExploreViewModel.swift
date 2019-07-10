//
//  PhotoExploreViewModel.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/7/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

class PhotoExploreViewModel {
    var photos: [Photo] = []
    let operationQueue = OperationQueue()
    
    func fetchPhotos() {
        let flickrOperation = FetchPhotosFromFlickrOperation()
        let unsplashOperation = FetchPhotosFromUnsplashOperation()

        unsplashOperation.completionBlock = {
            DispatchQueue.main.async {
                self.photos = DatabaseManager.shared.fetchAllPhotos()
                print(self.photos)
            }
        }

        unsplashOperation.addDependency(flickrOperation)

        operationQueue.isSuspended = true
        operationQueue.addOperation(flickrOperation)
        operationQueue.addOperation(unsplashOperation)
        operationQueue.isSuspended = false
    }
}
