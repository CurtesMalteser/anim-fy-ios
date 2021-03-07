//
//  DataRepositoryProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

protocol DataRepositoryProtocol {
    var type: DataRepositoryType { get }
    var dataList: Array<DataCellModel> { get set }
    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> { get set }
    var statusDelegate: StatusDelegateProtocol! { get set }
    func downloadCollection()
    func downloadMoreCollection()
    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>?
    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String)
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

enum DataRepositoryType: Int16 {
    case anime = 0
    case manga = 1
}

