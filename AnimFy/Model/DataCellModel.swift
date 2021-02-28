//
//  DataCellModel.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

struct DataCellModel: RowsProtocol {
    let datumID: String
    let title: String
    let imageURL: URL?
    let synopsis: String
}

struct UserOptionRowModel: RowsProtocol {
    let favorite: Bool
    let forLater: Bool
}