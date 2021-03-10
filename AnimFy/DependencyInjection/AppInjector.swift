//
//  AppInjector.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

import Foundation

class AppInjector {

    private var detailsViewModel: DetailsViewModel? = nil

    let dataController: DataController = DataController()

    lazy var animeRepository = AnimeRepository(repositoryType: .anime, mapper: DataRepositoryMapper(dataController: dataController, repositoryType: .anime))
    lazy var mangaRepository = MangaRepository(repositoryType: .manga, mapper: DataRepositoryMapper(dataController: dataController, repositoryType: .manga))

    private var storedDataRepository: StoredDatumRepository? = nil

    func injectDetailsViewModel(datumID: String, repositoryType type: DataRepositoryType) -> DetailsViewModel {
        if let detailsViewModel = detailsViewModel {
            return detailsViewModel
        } else {
            switch type {
            case .anime:
                detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: animeRepository)
            case .manga:
                detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: mangaRepository)
            case .favorite,
                 .saveForLater:
                if storedDataRepository == nil {
                    storedDataRepository = StoredDatumRepository(repositoryType: type, mapper: DataRepositoryMapper(dataController: dataController, repositoryType: type))
                    detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: storedDataRepository!)
                } else {
                    detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: storedDataRepository!)
                }
            }

            return detailsViewModel!
        }
    }

    func destroyDetailsViewModel() {
        detailsViewModel = nil
    }

    func injectStoredDatumRepository(repositoryType type: DataRepositoryType) -> DataRepositoryProtocol {
        if storedDataRepository == nil {
            storedDataRepository = StoredDatumRepository(repositoryType: type, mapper: DataRepositoryMapper(dataController: dataController, repositoryType: type))
        }
        return storedDataRepository!
    }

    func destroyStoredDatumRepository() {
        storedDataRepository = nil
    }
}
