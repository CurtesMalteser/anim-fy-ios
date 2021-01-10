//
//  AnimFyApiConfiguration.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//
//  Based on https://batuhangobekli.medium.com/preparing-networking-layer-using-alamofire-ios-6d043cc70aff
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}
