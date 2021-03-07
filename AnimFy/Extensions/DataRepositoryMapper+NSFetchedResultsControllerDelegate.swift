//
//  DataRepositoryMapper+NSFetchedResultsControllerDelegate.swift
//  AnimFy
//
//  Created by António Bastião on 07.03.21.
//

import CoreData

extension DataRepositoryMapper: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert,
             .update,
             .delete:
            updateDetailsSectionDictionaryUserOption(modifiedObject: anObject, type: type)

        default:
            print("NSFetchedResultsControllerDelegate type: \(type) not handled!")
        }

    }

    private func updateDetailsSectionDictionaryUserOption(modifiedObject anObject: Any, type: NSFetchedResultsChangeType) {
        if let storeDatumDetails = (anObject as? DatumDetails) {
            if let datumID = storeDatumDetails.datumID {

                if let datumDetails = getDatumDetailsBy(id: storeDatumDetails.datumID!) {

                    let posterSection = datumDetails.first { section in
                        section is PosterSection
                    } as! PosterSection

                    let dataCell = posterSection.rows.first { row in
                        row is DataCellModel
                    } as! DataCellModel

                    let favorite = type == .delete ? false : storeDatumDetails.favorite
                    let forLater = type == .delete ? false : storeDatumDetails.saveForLater

                    let modPosterSection: PosterSection = PosterSection(label: posterSection.label, rows: [
                        dataCell,
                        UserOptionRowModel(favorite: favorite, forLater: forLater)
                    ])

                    let attributesSection = datumDetails.first { section in
                        section is AttributesSection
                    } as! AttributesSection

                    let sectionArray: Array<DetailsSectionProtocol> = [
                        modPosterSection,
                        attributesSection
                    ]

                    detailsSectionDictionary[datumID] = sectionArray

                }
            }
        }
    }
}

