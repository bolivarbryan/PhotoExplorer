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
    case pexel(description: String, url: String)
    case pixabay(tags: String, url: String)

    var pictureURL: String {
        switch self {
        case  let .flickr(farmID: farmID, serverID: serverID, id: id, secret: secret, title: _):
            return "https://farm\(farmID).staticflickr.com/\(serverID)/\(id)_\(secret).jpg"
        case let .unsplash(description: _, url: url):
            return url
        case let .pexel(description: _, url: url):
            return url
        case let .pixabay(tags: _, url: url):
            return url
        }
    }

    var description: String {
        switch self {
        case let .flickr(farmID: _, serverID: _, id: _, secret: _, title: title):
            return title
        case let .unsplash(description: description, url: _):
            return description
        case let .pexel(description: description, url: _):
            return description
        case let .pixabay(tags: tags, url: _):
            return tags
        }
    }

    var source: String {
        switch self {
        case .flickr(farmID: _, serverID: _, id: _, secret: _, title: _):
            return "Flickr"
        case .unsplash(description: _, url: _):
            return "Unsplash"
        case .pexel(description: _, url: _):
            return "Pexel"
        case .pixabay(tags: _, url: _):
            return "Pixabay"
        }
    }

    static func reverseParse(photo: PhotoEntity) -> Photo? {
        if photo.source == "Flickr" {
            let url = photo.pictureURL!

            //Dev Comment: I used next splitting method for flickr api structure following their documentation
            //A better approach in this case could be using a Regex

            var splittedURL = url.dropFirst(12)
            splittedURL = splittedURL.dropLast(4)
            var subgroup = splittedURL.split(separator: "/")

            guard
                let farmID = subgroup.first?.split(separator: ".").first,
                let secret = subgroup.last?.split(separator: "_").last,
                let id = subgroup[2].split(separator: "_").first
                else { return nil }


            return Photo.flickr(farmID: String(farmID),
                                serverID: String(subgroup[1]),
                                id: String(id),
                                secret: String(secret),
                                title: photo.caption!)

        } else if photo.source == "Unsplash" {
            return Photo.unsplash(description: photo.caption!,
                                  url: photo.pictureURL!)
        } else if photo.source == "Pexel" {
            return Photo.pexel(description: photo.caption!,
                                  url: photo.pictureURL!)
        } else if photo.source == "Pixabay" {
            return Photo.pixabay(tags: photo.caption!, url: photo.pictureURL!)
        }
        
        return nil
    }

    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.source == rhs.source &&
        lhs.pictureURL == rhs.pictureURL
    }
}
