
//
//  PixabayService.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum PixabayService {
    static let serverURL = "https://pixabay.com/api"
    static let client_key = "1412809-c4dc9b40a01392c81d47a34bb"

    case search(query: String)
    case fetchRecents
}

extension PixabayService {

    var endpoint: String {
        switch self {
        case .fetchRecents, .search(query: _):
            return "/"
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
                "key": PixabayService.client_key,
                "image_type": "photo",
                "order": "latest"
            ]
            return URLParams
        case let .search(query: query):
            let URLParams = [
                "page": "1",
                "key": PixabayService.client_key,
                "q": query
            ]
            return URLParams
        }
    }

    var request: URLRequest {
        guard
            var URL = URL(string: PixabayService.serverURL + endpoint)
            else { fatalError("Invalid Server URL") }

        switch self {
        case .fetchRecents:
            URL = URL.appendingQueryParameters(PixabayService.fetchRecents.urlParameters)
        case let .search(query: query):
            URL = URL.appendingQueryParameters(PixabayService.search(query: query).urlParameters)
        }
        var request = URLRequest(url: URL)
        request.httpMethod = PixabayService.fetchRecents.method
        return request
    }
}

struct PixabayResponse: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let largeImageURL: String
    let tags: String
}
