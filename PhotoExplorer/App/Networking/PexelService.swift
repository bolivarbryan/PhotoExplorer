//
//  PexelService.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/10/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum PexelService {
    static let serverURL = "https://api.pexels.com/v1"
    static let authorization = "563492ad6f917000010000017b1181f39a714e628db8643053d3a5df"

    case search(query: String)
    case fetchRecents
}

extension PexelService {

    var endpoint: String {
        switch self {
        case .fetchRecents:
            return "/curated"
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
                "per_page": "50"
            ]
            return URLParams
        case let .search(query: query):
            let URLParams = [
                "page": "1",
                "per_page": "50",
                "query": query
            ]
            return URLParams
        }
    }

    var request: URLRequest {
        guard
            var URL = URL(string: PexelService.serverURL + endpoint)
            else { fatalError("Invalid Server URL") }

        switch self {
        case .fetchRecents:
            URL = URL.appendingQueryParameters(PexelService.fetchRecents.urlParameters)
        case let .search(query: query):
            URL = URL.appendingQueryParameters(PexelService.search(query: query).urlParameters)
        }
        var newRequest = URLRequest(url: URL)
        newRequest.addValue(PexelService.authorization, forHTTPHeaderField: "Authorization")
        newRequest.httpMethod = PexelService.fetchRecents.method
        return newRequest
    }
}

struct PexelDecoder: Codable {
    let photos: [PexelPhoto]
}

struct PexelPhoto: Codable {
    let photographer: String
    let src: PexelSrc
}

struct PexelSrc: Codable {
    let medium: String
}
