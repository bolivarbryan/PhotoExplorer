//
//  FetchPhotosFromPixabay.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

class FetchPhotosFromPixabayOperation: BaseOperation {

    override init() {}

    override func execute() {
        API.pixabay(endpoint: .fetchRecents).request { photos in
            DispatchQueue.main.async {
                photos.forEach({ (photo) in
                    DatabaseManager.shared.save(photo: photo)
                })
            }
            self.finish()
        }
    }
}
