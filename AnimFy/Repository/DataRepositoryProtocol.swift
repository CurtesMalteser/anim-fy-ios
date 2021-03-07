//
//  DataRepositoryProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation
import CoreData

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

extension AnimeRepository: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        print("did change \(type)")
        switch type {
        case .insert:
            if let id = (anObject as? DatumDetails) {
                let x = detailsSectionDictionary[id.datumID!]
                print("insert \(id.datumID!) and title \(id.title!)")
            }

        case .delete:
            if let id = (anObject as! DatumDetails).datumID {
                let x = detailsSectionDictionary[id]
                print("delete \(id)")
            }

        /*default:
            print("NSFetchedResultsControllerDelegate type: \(type) not handled!")
        }*/
        case .move:
            print("move:")
        case .update:
            print("updaye:")

        @unknown default:
            print("NSFetchedResultsControllerDelegate type: \(type) not handled!")

        }
    }
}
