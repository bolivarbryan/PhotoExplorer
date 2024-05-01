//
//  PhotoTests.swift
//  PhotoExplorerTests
//
//  Created by Bryan A Bolivar M on 1/05/24.
//  Copyright © 2024 Bolivarbryan. All rights reserved.
//

import Foundation
@testable import PhotoExplorer
import XCTest

class PhotoTests: XCTestCase {

    // Test Flickr photo URL generation
    func testFlickrURLGeneration() {
        let flickrPhoto = Photo.flickr(farmID: "1", serverID: "123", id: "456", secret: "789", title: "Test Flickr Photo")
        XCTAssertEqual(flickrPhoto.pictureURL, "https://farm1.staticflickr.com/123/456_789.jpg", "Flickr URL generation failed")
    }

    // Test Unsplash photo URL generation
    func testUnsplashURLGeneration() {
        let unsplashPhoto = Photo.unsplash(description: "Test Unsplash Photo", url: "https://unsplash.com/photo")
        XCTAssertEqual(unsplashPhoto.pictureURL, "https://unsplash.com/photo", "Unsplash URL generation failed")
    }

    // Test Pexel photo URL generation
    func testPexelURLGeneration() {
        let pexelPhoto = Photo.pexel(description: "Test Pexel Photo", url: "https://pexels.com/photo")
        XCTAssertEqual(pexelPhoto.pictureURL, "https://pexels.com/photo", "Pexel URL generation failed")
    }

    // Test Pixabay photo URL generation
    func testPixabayURLGeneration() {
        let pixabayPhoto = Photo.pixabay(tags: "Test Pixabay Photo", url: "https://pixabay.com/photo")
        XCTAssertEqual(pixabayPhoto.pictureURL, "https://pixabay.com/photo", "Pixabay URL generation failed")
    }

    // Test description retrieval
    func testDescriptionRetrieval() {
        let flickrPhoto = Photo.flickr(farmID: "1", serverID: "123", id: "456", secret: "789", title: "Test Flickr Photo")
        XCTAssertEqual(flickrPhoto.description, "Test Flickr Photo", "Description retrieval failed")

        let unsplashPhoto = Photo.unsplash(description: "Test Unsplash Photo", url: "https://unsplash.com/photo")
        XCTAssertEqual(unsplashPhoto.description, "Test Unsplash Photo", "Description retrieval failed")

        let pexelPhoto = Photo.pexel(description: "Test Pexel Photo", url: "https://pexels.com/photo")
        XCTAssertEqual(pexelPhoto.description, "Test Pexel Photo", "Description retrieval failed")

        let pixabayPhoto = Photo.pixabay(tags: "Test Pixabay Photo", url: "https://pixabay.com/photo")
        XCTAssertEqual(pixabayPhoto.description, "Test Pixabay Photo", "Description retrieval failed")
    }

    // Test source retrieval
    func testSourceRetrieval() {
        let flickrPhoto = Photo.flickr(farmID: "1", serverID: "123", id: "456", secret: "789", title: "Test Flickr Photo")
        XCTAssertEqual(flickrPhoto.source, "Flickr", "Source retrieval failed")

        let unsplashPhoto = Photo.unsplash(description: "Test Unsplash Photo", url: "https://unsplash.com/photo")
        XCTAssertEqual(unsplashPhoto.source, "Unsplash", "Source retrieval failed")

        let pexelPhoto = Photo.pexel(description: "Test Pexel Photo", url: "https://pexels.com/photo")
        XCTAssertEqual(pexelPhoto.source, "Pexel", "Source retrieval failed")

        let pixabayPhoto = Photo.pixabay(tags: "Test Pixabay Photo", url: "https://pixabay.com/photo")
        XCTAssertEqual(pixabayPhoto.source, "Pixabay", "Source retrieval failed")
    }

    // Test photo equality
    func testPhotoEquality() {
        let flickrPhoto1 = Photo.flickr(farmID: "1", serverID: "123", id: "456", secret: "789", title: "Test Flickr Photo")
        let flickrPhoto2 = Photo.flickr(farmID: "1", serverID: "123", id: "456", secret: "789", title: "Test Flickr Photo")
        XCTAssertEqual(flickrPhoto1, flickrPhoto2, "Photo equality test failed")

        let unsplashPhoto1 = Photo.unsplash(description: "Test Unsplash Photo", url: "https://unsplash.com/photo")
        let unsplashPhoto2 = Photo.unsplash(description: "Test Unsplash Photo", url: "https://unsplash.com/photo")
        XCTAssertEqual(unsplashPhoto1, unsplashPhoto2, "Photo equality test failed")

        let pexelPhoto1 = Photo.pexel(description: "Test Pexel Photo", url: "https://pexels.com/photo")
        let pexelPhoto2 = Photo.pexel(description: "Test Pexel Photo", url: "https://pexels.com/photo")
        XCTAssertEqual(pexelPhoto1, pexelPhoto2, "Photo equality test failed")

        let pixabayPhoto1 = Photo.pixabay(tags: "Test Pixabay Photo", url: "https://pixabay.com/photo")
        let pixabayPhoto2 = Photo.pixabay(tags: "Test Pixabay Photo", url: "https://pixabay.com/photo")
        XCTAssertEqual(pixabayPhoto1, pixabayPhoto2, "Photo equality test failed")
    }
}
