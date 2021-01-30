//
//  DataCellModel.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

struct DataCellModel {

    let datumID: String
    let title: String
    let imageURL: URL?

    init(id: String, title: String, imageURL: URL?) {
        datumID = id
        self.title = title
        self.imageURL = imageURL
    }

}