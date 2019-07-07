//
//  FetchPhotosOperation.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/7/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

class FetchPhotosFromFlickrOperation: BaseOperation {
    var photos: [Photo] = []

    override init() {}

    override func execute() {
        API.flickr(endpoint: .fetchRecents).request { photos in
            DispatchQueue.main.async {
                self.photos = photos
            }
            self.finish()
        }
    }
}
