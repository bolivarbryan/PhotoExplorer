//
//  API.swift
//  PhotoExplorer
//
//  Created by Bryan A Bolivar M on 7/5/19.
//  Copyright © 2019 Bolivarbryan. All rights reserved.
//

import Foundation

enum API {
    case flickr(endpoint: FlickrService)
    case unsplash(endpoint: UnsplashService)
}

extension API {
    func request(completion: @escaping (_ response: [Photo]) -> Void) {
        switch self {
        case .flickr(endpoint: .fetchRecents):
            fetchRecentPhotosFromFlickr(completion: completion)
        case let .flickr(endpoint: .search(query: query)):
            searchPhotosFromFlickr(query: query, completion: completion)
        case .unsplash(endpoint: .fetchRecents):
            fetchRecentPhotosFromUnsplash(completion: completion)
        case let .unsplash(endpoint: .search(query: query)):
            searchPhotosFromUnsplash(query: query, completion: completion)
        }
    }

    func fetchRecentPhotosFromFlickr(completion: @escaping (_ response: [Photo]) -> Void) {
        print("fetching recents from flickr")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: FlickrService.fetchRecents.request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                do {
                    let jsonResponse = try JSONDecoder().decode(FlickrDecoder.self, from: data!)
                    let photos = jsonResponse.photos.photo.map { Photo.flickr(farmID: "\($0.farm)",
                        serverID: $0.server,
                        id: $0.id,
                        secret: $0.secret,
                        title: $0.title) }
                    completion(photos)

                } catch {
                    print("parsing error", error.localizedDescription)
                }
            }else {
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    func searchPhotosFromFlickr(query: String, completion: @escaping (_ response: [Photo]) -> Void) {
        print("searching \(query) from flickr")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: FlickrService.search(query: query).request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                do {
                    let jsonResponse = try JSONDecoder().decode(FlickrDecoder.self, from: data!)
                    let photos = jsonResponse.photos.photo.map { Photo.flickr(farmID: "\($0.farm)",
                        serverID: $0.server,
                        id: $0.id,
                        secret: $0.secret,
                        title: $0.title) }
                    completion(photos)

                } catch {
                    print("parsing error", error.localizedDescription)
                }
            }else {
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }

    func fetchRecentPhotosFromUnsplash(completion: @escaping (_ response: [Photo]) -> Void) {
        print("fetching recents from unsplash")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: UnsplashService.fetchRecents.request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                do {
                    let jsonResponse = try JSONDecoder().decode([UnsplashPhoto].self, from: data!)
                    let photos = jsonResponse.map { Photo.unsplash(description: $0.description ?? "no description", url: $0.urls.regular)}
                    completion(photos)

                } catch {
                    print("parsing error", error.localizedDescription)
                }
            }else {
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }


    private func searchPhotosFromUnsplash(query:String, completion: @escaping (_ photos: [Photo]) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil, delegateQueue: nil)

        let task = session.dataTask(with: UnsplashService.search(query: query).request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")

                do {
                    let jsonResponse = try JSONDecoder().decode(UnsplashResponse.self, from: data!)
                    let photos = jsonResponse.results.map { Photo.unsplash(description: $0.description ?? "no description", url: $0.urls.regular)}
                    completion(photos)

                } catch {
                    print("parsing error", error.localizedDescription)
                }
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }

}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
