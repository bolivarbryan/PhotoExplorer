//
//  PhotoExploreViewModel.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/7/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

protocol  PhotoExploreViewModelDelegate {
    func didFinishFetchingPhotos()
}

class PhotoExploreViewModel {
    var photos: [Photo] = []

    var photosByService: [[Photo]] {
        // Dev Notes: The way I'm filtering should be improved by using the enum property instead of hardcoding the source value. reason: potential typo error could return 0 results

        let flickrPhotos = photos.filter { $0.source == "Flickr" }
        let unsplashPhotos = photos.filter { $0.source == "Unsplash" }
        let pexelPhotos = photos.filter { $0.source == "Pexel" }

        return [flickrPhotos, unsplashPhotos, pexelPhotos]
    }

    let operationQueue = OperationQueue()

    var delegate: PhotoExploreViewModelDelegate?
    
    func fetchPhotos() {
        let flickrOperation = FetchPhotosFromFlickrOperation()
        let unsplashOperation = FetchPhotosFromUnsplashOperation()
        let pexelOperation = FetchPhotosFromPexelOperation()

        pexelOperation.completionBlock = {
            DispatchQueue.main.async {
                self.photos = DatabaseManager.shared.fetchAllPhotos()
                self.delegate?.didFinishFetchingPhotos()
            }
        }

        unsplashOperation.completionBlock = {
            DispatchQueue.main.async {
                self.photos = DatabaseManager.shared.fetchAllPhotos()
                self.delegate?.didFinishFetchingPhotos()
            }
        }

        pexelOperation.completionBlock = {
            DispatchQueue.main.async {
                self.photos = DatabaseManager.shared.fetchAllPhotos()
                self.delegate?.didFinishFetchingPhotos()
            }
        }

        operationQueue.isSuspended = true
        operationQueue.addOperation(flickrOperation)
        operationQueue.addOperation(unsplashOperation)
        operationQueue.addOperation(pexelOperation)
        operationQueue.isSuspended = false
    }
}
