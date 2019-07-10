//
//  UnsplashService.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum UnsplashService {
    static let serverURL = "https://api.unsplash.com"
    static let client_id = "a70408e1152b36858ed2aff1cea5b1927c2c34997aa25d5a7c30788729bede4d"

    case search(query: String)
    case fetchRecents
}

extension UnsplashService {

    var endpoint: String {
        switch self {
        case .fetchRecents:
            return "/photos"
        case .search(query: _):
            return "/search/photos"
        }
    }

    var method: String {
        switch self {
        case .fetchRecents, .search(query: _):
            return "GET"
        }
    }

    var urlParameters: [String: String] {
        switch self {
        case .fetchRecents:
            let URLParams = [
                "page": "1",
                "client_id": UnsplashService.client_id,
                "per_page": "50"
            ]
            return URLParams
        case let .search(query: query):
            let URLParams = [
                "page": "1",
                "per_page": "50",
                "client_id": UnsplashService.client_id,
                "query": query
            ]
            return URLParams
        }
    }

    var request: URLRequest {
        guard
            var URL = URL(string: UnsplashService.serverURL + endpoint)
            else { fatalError("Invalid Server URL") }

        switch self {
        case .fetchRecents:
            URL = URL.appendingQueryParameters(UnsplashService.fetchRecents.urlParameters)
        case let .search(query: query):
            URL = URL.appendingQueryParameters(UnsplashService.search(query: query).urlParameters)
        }
        var request = URLRequest(url: URL)
        request.httpMethod = UnsplashService.fetchRecents.method
        return request
    }
}

struct UnsplashPhoto: Codable {
    let urls: UnsplashPhotoURL
    let description: String?
}

struct UnsplashPhotoURL: Codable {
    let raw: String
    let full: String
    let regular: String
    let thumb: String
}

struct UnsplashResponse: Codable {
    let results: [UnsplashPhoto]
}
