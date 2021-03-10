//
//  StoredDatumRepository.swift
//  AnimFy
//
//  Created by António Bastião on 10.03.21.
//


import Alamofire
import CoreData

class StoredDatumRepository: NSObject, DataRepositoryProtocol {

    var type: DataRepositoryType

    var dataList: Array<DataCellModel> = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]

    var statusDelegate: StatusDelegateProtocol!

    init(repositoryType: DataRepositoryType) {
        type = repositoryType
    }

    func downloadCollection() {
        // todo
    }

    func downloadMoreCollection() {
        // todo
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        detailsSectionDictionary.first?.value
    }

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {
        // todo
    }


}
