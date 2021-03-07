//
//  DataRepositoryMapper.swift
//  AnimFy
//
//  Created by António Bastião on 07.03.21.
//

import CoreData

class DataRepositoryMapper: NSObject {

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]


    private let _dataController: DataController

    private var _fetchedResultsController: NSFetchedResultsController<DatumDetails>!

    private lazy var _fetchRequest: NSFetchRequest<DatumDetails> = {

        let fetchRequest: NSFetchRequest<DatumDetails> = DatumDetails.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datumID", ascending: false)]
        return fetchRequest
    }()

    private let _type: DataRepositoryType

    init(dataController controller: DataController, repositoryType type: DataRepositoryType) {
        _dataController = controller
        _type = type

        super.init()

        initFetchedResultsController()

    }

    private func initFetchedResultsController() {

        _fetchedResultsController = NSFetchedResultsController(
                fetchRequest: _fetchRequest,
                managedObjectContext: _dataController.backgroundContext,
                sectionNameKeyPath: nil,
                cacheName: nil
        )

        _fetchedResultsController.delegate = self
    }

    /**
     Initializes the fetchedResultsController and fetch the DatumDetails for datumID.
    */
    func initUserOptionRowModel(id: String) -> UserOptionRowModel {

        var userOptionRowModel: UserOptionRowModel = UserOptionRowModel(favorite: false, forLater: false)

        updateRequestPredicate(id: id)

        do {
            try _fetchedResultsController.performFetch()
        } catch {
            fatalError("Could not perform fetch:\n\(error.localizedDescription)")
        }

        _fetchedResultsController.managedObjectContext.doTry(
                onSuccess: { context in
                    let result = try context.fetch(_fetchRequest)


                    if let datumDetail = result.first {
                        userOptionRowModel = UserOptionRowModel(favorite: datumDetail.favorite, forLater: datumDetail.saveForLater)
                    }

                },
                onError: { error in
                    print("fetch result \(error.localizedDescription)")
                }
        )

        return userOptionRowModel
    }

    private func updateRequestPredicate(id: String) {
        let subPredicates = [
            NSPredicate(format: "datumID == %@", id),
            NSPredicate(format: "datumType == \(_type.rawValue)")
        ]
        _fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        detailsSectionDictionary[id]
    }

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {

        if (rowCell.favorite == false && rowCell.forLater == false) {
            deleteDatumDetails(datumID: id)
        } else {
            saveDatumDetailsFor(datumID: id, rowCell: rowCell)
        }

    }

    private func saveDatumDetailsFor(datumID id: String, rowCell: UserOptionRowModel) {

        updateRequestPredicate(id: id)

        _fetchedResultsController.managedObjectContext.doTry(onSuccess: { context in
            let result = try context.fetch(_fetchRequest)

            if result.count == 0 {
                saveDatumDetails(id: id, rowCell: rowCell)
            } else {
                updateDatumDetails(datumDetailsList: result, rowCell: rowCell)
            }
            try context.save()
        }, onError: { error in
            print("Failed to fetch DatumDetails to delete \(error)")
        })

    }

    private func updateDatumDetails(datumDetailsList result: [DatumDetails], rowCell: UserOptionRowModel) {
        result.forEach { result in
            result.favorite = rowCell.favorite
            result.saveForLater = rowCell.forLater
        }
    }

    private func saveDatumDetails(id: String, rowCell: UserOptionRowModel) {
        if let datumDetails = getDatumDetailsBy(id: id) {

            let section = datumDetails.first { section in
                section is PosterSection
            } as! PosterSection

            let dataCell = section.rows.first { row in
                row is DataCellModel
            } as! DataCellModel

            _fetchedResultsController.managedObjectContext.doTry(onSuccess: { context in
                initializeDatumDetails(context: context, dataCell: dataCell, rowCell: rowCell)
            }, onError: { error in
                print("Failed to store DatumDetails \(error)")
            })

        }
    }

    private func deleteDatumDetails(datumID id: String) {

        updateRequestPredicate(id: id)

        _fetchedResultsController.managedObjectContext.doTry(onSuccess: { context in

            let result = try context.fetch(_fetchRequest)

            result.forEach { result in
                print("deleteDatumDetails")

                context.doTry(onSuccess: { context in
                    context.delete(result)
                }, onError: { error in
                    print("Failed to delete DatumDetails \(error)")
                })
            }

            try context.save()
        }, onError: { error in
            print("Failed to fetch DatumDetails to delete \(error)")
        })
    }

    private func initializeDatumDetails(context: NSManagedObjectContext, dataCell: DataCellModel, rowCell: UserOptionRowModel) {
        let datum = DatumDetails(context: context)
        datum.datumType = _type.rawValue
        datum.datumID = dataCell.datumID
        datum.imageURL = dataCell.imageURL
        datum.synopsys = dataCell.synopsis
        datum.title = dataCell.title
        datum.favorite = rowCell.favorite
        datum.saveForLater = rowCell.forLater
    }

}
