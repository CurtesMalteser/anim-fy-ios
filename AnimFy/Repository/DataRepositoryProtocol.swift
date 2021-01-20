//
//  DataRepositoryProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

protocol DataRepositoryProtocol {
    var dataList: Array<DataCellModel> { get set }
    func downloadCollection()
}

extension DataRepositoryProtocol {
    func tryGetImageURL(link: String?) -> URL? {
        if let link = link {
            return URL(string: link)
        } else {
            return nil
        }
    }
}