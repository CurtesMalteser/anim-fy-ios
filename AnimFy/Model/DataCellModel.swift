//
//  DataCellModel.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

class DataCellModel {

    let id: String
    let title: String
    let imageURL: URL?

    init(id: String, title: String, imageURL: URL?) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }

}