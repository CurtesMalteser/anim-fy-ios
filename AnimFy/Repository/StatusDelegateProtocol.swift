//
//  StatusDelegateProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 22.01.21.
//

import Foundation

protocol StatusDelegateProtocol {
    func postStatus(_ status: Status)
}

enum Status {
    case Success
    case Loading
    case Error(error: Error)
}