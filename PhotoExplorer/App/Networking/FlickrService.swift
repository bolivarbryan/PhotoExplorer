//
//  FlickrService.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum FlickrService {
    static let serverURL = "https://www.flickr.com/services/rest/"
    static let apiKey = "be7c4a001cb923bcc48cd2a80f8f42c3"

    case search(query: String)
    case fetchRecents
}

extension FlickrService {
    var method: String {
        switch self {
        case .fetchRecents, .search(query: _):
            return "GET"
        }
    }

    var urlParameters: [String: String] {
        switch self {
        case .fetchRecents:
            let minuteInSeconds = 60.0
            let date = Date().timeIntervalSince1970 - minuteInSeconds
            let URLParams = [
                "method": "flickr.photos.search",
                "api_key": FlickrService.apiKey,
                "format": "json",
                "min_upload_date": "\(date)",
                "nojsoncallback": "1",
                "per_page": "20",
            ]
            return URLParams
        case let .search(query: query):
            let URLParams = [
                "method": "flickr.photos.search",
                "api_key": FlickrService.apiKey,
                "tags": query,
                "format": "json",
                "text": query,
                "nojsoncallback": "1",
                "per_page": "20"
            ]
            return URLParams
        }
    }

    var request: URLRequest {
        guard
            var URL = URL(string: FlickrService.serverURL)
            else { fatalError("Invalid Server URL") }

        switch self {
        case .fetchRecents:
            URL = URL.appendingQueryParameters(FlickrService.fetchRecents.urlParameters)
        case let .search(query: query):
            URL = URL.appendingQueryParameters(FlickrService.search(query: query).urlParameters)
        }
        var request = URLRequest(url: URL)
        request.httpMethod = FlickrService.fetchRecents.method
        return request
    }
}


struct FlickrDecoder: Codable {
    let photos: PhotoDecoder
}

struct PhotoDecoder: Codable {
    let photo: [FlickrPhoto]
}


struct FlickrPhoto: Codable {
    let id: String
    let title: String
    let farm: Int
    let server: String
    let secret: String
}
