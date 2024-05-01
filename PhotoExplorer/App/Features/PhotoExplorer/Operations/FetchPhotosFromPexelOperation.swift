//
//  FetchPhotosFromPexelOperation.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation
class FetchPhotosFromPexelOperation: BaseOperation {

    override init() {}

    override func execute() {
        API.pexel(endpoint: .fetchRecents).request { photos in
            DispatchQueue.main.async {
                photos.forEach({ (photo) in
                    DatabaseManager.shared.save(photo: photo)
                })
            }
            self.finish()
        }
    }
}
