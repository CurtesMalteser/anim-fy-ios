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

    var viewTitle: String {
        get {
            let queryTypeString = (queryType == DataRepositoryType.anime)
                    ? "Anime"
                    : "Manga"

            let typeString = (type == DataRepositoryType.favorite)
                    ? "favorites"
                    : "for later"

            return "\(queryTypeString) \(typeString)"
        }
    }

    var dataList: Array<DataCellModel> = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> {
        get {
            _mapper.detailsSectionDictionary
        }
        set {
            _mapper.detailsSectionDictionary = newValue
        }
    }

    private var _originalDatumArray: Array<DatumDetails> = []

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    private let _mapper: DataRepositoryMapper

    init(repositoryType: DataRepositoryType, mapper: DataRepositoryMapper) {
        type = repositoryType
        _mapper = mapper
    }

    func downloadCollection() {

        if (isInProgress || !dataList.isEmpty) {
            return
        }

        setDownloadStarted()

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

        _mapper.fetchAllFor(predicate: predicate,
                completion: { datumDetailsArray in

                    _originalDatumArray = datumDetailsArray

                    datumDetailsArray.forEach { details in
                        composeAnimeDetailRows(datum: details)
                    }

                    DispatchQueue.main.async {
                        self.setCompletedStatus(.Success)
                    }
                }, errorHandler: { error in
            DispatchQueue.main.async {
                self.setCompletedStatus(.Error(error: error))
            }
        })
    }

    func downloadMoreCollection() {
        if (isInProgress || dataList.isEmpty) {
            return
        }

        setDownloadStarted()

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

        _mapper.fetchAllFor(predicate: predicate,
                completion: { datumDetailsArray in

                    performDetailRowsDiff(datumDetailsArray)

                    DispatchQueue.main.async {
                        self.setCompletedStatus(.Success)
                    }
                }, errorHandler: { error in
            DispatchQueue.main.async {
                self.setCompletedStatus(.Error(error: error))
            }
        })

    }

    private func performDetailRowsDiff(_ array: [DatumDetails]) {

        dataList = []
        detailsSectionDictionary = [:]

        array.forEach { details in
            composeAnimeDetailRows(datum: details)
        }


    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        _mapper.getDatumDetailsBy(id: id)
    }

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {
        _mapper.storeDatumDetailsFor(cell: rowCell, datumID: id)
    }

    private func composeAnimeDetailRows(datum: DatumDetails) {

        let dataCell = DataCellModel(datumID: datum.datumID!, title: datum.title!, imageURL: datum.imageURL, synopsis: datum.synopsys!)
        dataList.append(dataCell)

        detailsSectionDictionary[datum.datumID!] = [
            PosterSection(
                    label: datum.title!,
                    rows: [dataCell,
                           UserOptionRowModel(favorite: datum.favorite, forLater: datum.saveForLater)
                    ]),
        ]
    }

    private func setDownloadStarted() {
        statusDelegate.postStatus(.Loading)
        isInProgress = true
    }

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }

}

extension Array where Element: Hashable {
    func difference(element other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}