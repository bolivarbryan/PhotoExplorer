//
//  FlickrServiceTests.swift
//  PhotoExplorerTests
//
//  Created by Bryan A Bolivar M on 1/05/24.
//  Copyright © 2024 Bolivarbryan. All rights reserved.
//

import Foundation
@testable import PhotoExplorer
import XCTest

class FlickrServiceTests: XCTestCase {

    // Test fetchRecents method
    func testFetchRecentsMethod() {
        let fetchRecentsService = FlickrService.fetchRecents
        XCTAssertEqual(fetchRecentsService.method, "GET", "Fetch recents method is incorrect")
    }

    // Test search method
    func testSearchMethod() {
        let searchService = FlickrService.search(query: "landscape")
        XCTAssertEqual(searchService.method, "GET", "Search method is incorrect")
    }

    // Test fetchRecents urlParameters
    func testFetchRecentsURLParameters() {
        let fetchRecentsService = FlickrService.fetchRecents
        let timestamp = Int(Date().timeIntervalSince1970 - (60.0 * 10))
        guard let timestampString = fetchRecentsService.urlParameters["min_upload_date"] else {
            XCTFail("min_upload_date parameter is missing")
            return
        }
        XCTAssertEqual(timestampString, "\(timestamp)", "Value for key min_upload_date is incorrect")
    }

    // Test search urlParameters
    func testSearchURLParameters() {
        let searchService = FlickrService.search(query: "landscape")
        let expectedParams: [String: String] = [
            "method": "flickr.photos.search",
            "api_key": FlickrService.apiKey,
            "tags": "landscape",
            "format": "json",
            "text": "landscape",
            "nojsoncallback": "1",
            "per_page": "50"
        ]
        XCTAssertEqual(searchService.urlParameters, expectedParams, "Search URL parameters are incorrect")
    }

    // Test decoding FlickrDecoder
    func testFlickrDecoder() {
        let jsonData = """
        {
            "photos": {
                "photo": [
                    {
                        "id": "1",
                        "title": "Test Photo",
                        "farm": 1,
                        "server": "123",
                        "secret": "abc"
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        do {
            let flickrDecoder = try JSONDecoder().decode(FlickrDecoder.self, from: jsonData)
            XCTAssertEqual(flickrDecoder.photos.photo.count, 1, "Decoding FlickrDecoder failed")
            XCTAssertEqual(flickrDecoder.photos.photo[0].id, "1", "Decoding FlickrDecoder id failed")
            XCTAssertEqual(flickrDecoder.photos.photo[0].title, "Test Photo", "Decoding FlickrDecoder title failed")
            XCTAssertEqual(flickrDecoder.photos.photo[0].farm, 1, "Decoding FlickrDecoder farm failed")
            XCTAssertEqual(flickrDecoder.photos.photo[0].server, "123", "Decoding FlickrDecoder server failed")
            XCTAssertEqual(flickrDecoder.photos.photo[0].secret, "abc", "Decoding FlickrDecoder secret failed")
        } catch {
            XCTFail("Failed to decode FlickrDecoder: \(error.localizedDescription)")
        }
    }
}
