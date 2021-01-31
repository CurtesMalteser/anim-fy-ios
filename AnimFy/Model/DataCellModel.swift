//
//  DataCellModel.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

struct DataCellModel: DetailsSectionProtocol {

    let datumID: String
    let title: String
    let imageURL: URL?
    let synopsis: String

    init(id: String, title: String, imageURL: URL?, synopsis: String) {
        datumID = id
        self.title = title
        self.imageURL = imageURL
        self.synopsis = synopsis
    }

}