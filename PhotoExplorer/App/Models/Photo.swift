//
//  Photo.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum Photo {
    case flickr(farmID: String, serverID: String, id: String, secret: String, title: String)
    case unsplash(description: String, url: String)

    var pictureURL: String {
        switch self {
        case  let .flickr(farmID: farmID, serverID: serverID, id: id, secret: secret, title: _):
            return "https://farm\(farmID).staticflickr.com/\(serverID)/\(id)_\(secret).jpg"
        case let .unsplash(description: _, url: url):
            return url
        }
    }

    var description: String {
        switch self {
        case let .flickr(farmID: _, serverID: _, id: _, secret: _, title: title):
            return title
        case let .unsplash(description: description, url: _):
            return description
        }
    }

    var source: String {
        switch self {
        case .flickr(farmID: _, serverID: _, id: _, secret: _, title: _):
            return "Flickr"
        case .unsplash(description: _, url: _):
            return "Unsplash"
        }
    }
}
