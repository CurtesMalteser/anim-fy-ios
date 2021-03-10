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
    var queryType: DataRepositoryType!

    var dataList: Array<DataCellModel> = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]

    var statusDelegate: StatusDelegateProtocol!

    private let _mapper: DataRepositoryMapper

    init(repositoryType: DataRepositoryType, mapper: DataRepositoryMapper) {
        type = repositoryType
        _mapper = mapper
    }

    func downloadCollection() {

        var subPredicates: Array<NSPredicate> = [
            NSPredicate(format: "datumType == \(queryType.rawValue)")
        ]

        if type == .favorite {
            let query = NSPredicate(format: "favorite == \(true)")
            subPredicates.append(query)
        } else if type == .saveForLater {
            let query = NSPredicate(format: "saveForLater == \(true)")
            subPredicates.append(query)
        }

        let predicate: NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)

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
