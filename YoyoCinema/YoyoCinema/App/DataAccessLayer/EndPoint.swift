//
//  EndPoint.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: "1f54bd990f1cdfb230adb312546d765d")]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems.append(contentsOf: queryItems)
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}

extension Endpoint {

    static func discoverList(sortby: String? = nil, withPage page: Int) -> Self {
        if let sort = sortby {
            return Endpoint(path: "/discover/movie",
            queryItems: [URLQueryItem(name: "page", value: String(page)), URLQueryItem(name: "sort_by", value: String(sort))])
        } else {
           return Endpoint(path: "/discover/movie",
            queryItems: [URLQueryItem(name: "page", value: String(page))])
        }

    }

    static func movieList(path: String, withPage page: Int) -> Self {
        Endpoint(path: "/movie/\(path)",
        queryItems: [URLQueryItem(name: "page", value: String(page))])
    }

    static func movie(withID id: Int) -> Self {
        Endpoint(path: "/movie/\(id)")
    }

    static func search(for query: String,
                       withPage page: Int) -> Self {
        Endpoint(
            path: "/search/movie",
            queryItems: [URLQueryItem(name: "query", value: String(query)), URLQueryItem(name: "page", value: String(page))]
        )
    }
}
