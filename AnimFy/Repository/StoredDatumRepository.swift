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

    private let _mapper: DataRepositoryMapper

    init(repositoryType: DataRepositoryType, mapper: DataRepositoryMapper) {
        type = repositoryType
        _mapper = mapper
    }

    func downloadCollection() {
        let predicate = NSPredicate(format: "datumType == \(type.rawValue)")
        _mapper.fetchAllFor(predicate: predicate)
    }

    func downloadMoreCollection() {
        // todo
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        _mapper.getDatumDetailsBy(id: id)
    }

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {
        _mapper.storeDatumDetailsFor(cell: rowCell, datumID: id)
    }


}
