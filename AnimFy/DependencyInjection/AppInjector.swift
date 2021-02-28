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

    lazy var animeRepository = AnimeRepository(dataController: dataController)
    lazy var mangaRepository = MangaRepository(dataController: dataController)


    func injectDetailsViewModel(datumID: String, repositoryType type: DataRepositoryType) -> DetailsViewModel {
        if let detailsViewModel = detailsViewModel {
            return detailsViewModel
        } else {
            if (type == .anime) {
                detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: animeRepository)
            } else if (type == .manga) {
                detailsViewModel = DetailsViewModel(datumID: datumID, dataRepository: mangaRepository)
            }
            return detailsViewModel!
        }
    }

    func destroyDetailsViewModel() {
        detailsViewModel = nil
    }
}
