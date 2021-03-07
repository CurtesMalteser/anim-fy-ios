//
//  AnimFyAPI.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//
//  Based on https://batuhangobekli.medium.com/preparing-networking-layer-using-alamofire-ios-6d043cc70aff
//

import Foundation
import Alamofire

enum AnimFyAPI: APIConfiguration {

    case anime
    case manga
    case pagination

    var method: HTTPMethod {
        switch self {
        case .anime:
            return .get
        case .manga:
            return .get
        case .pagination:
            return .get

        }
    }

    var path: String {
        switch self {
        case .anime:
            return "anime"
        case .manga:
            return "manga"
        case .pagination:
            return ""
        }
    }

    var parameters: RequestParams {
        switch self {
        case .anime:
            return .get([:])
        case .manga:
            return .get([:])
        case .pagination:
            return .get([:])
        }
    }

    func asURLRequest() throws -> URLRequest {

        let url = try Endpoint.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])

        case .url(let params):

            let queryParams = params.map { pair in
                URLQueryItem(name: pair.key, value: "\(pair.value)")
            }

            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url


        case .get(_):
            return urlRequest
        }

        return urlRequest
    }

    func parameterisedURLRequest(url: String) throws -> URLRequest {

        let url = try url.asURL()

        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])

        case .url(let params):

            let queryParams = params.map { pair in
                URLQueryItem(name: pair.key, value: "\(pair.value)")
            }

            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url


        case .get(_):
            return urlRequest
        }

        return urlRequest
    }

}