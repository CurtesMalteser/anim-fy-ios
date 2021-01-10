//
//  Endpoint.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//
//  Based on https://batuhangobekli.medium.com/preparing-networking-layer-using-alamofire-ios-6d043cc70aff
//

import Foundation
import Alamofire

struct Endpoint {
        static let baseURL = "https://kitsu.io/api/edge"
        static let collectionPath : () -> String = {
                ""
        }
}

enum HTTPHeaderField: String {
        case contentType = "Content-Type"
        case accept = "Accept"
}

enum ContentType: String {
        case json = "application/vnd.api+json"
}

enum RequestParams {
        case body(_:Parameters)
        case url(_:Parameters)
        case get(_:Parameters)
}
