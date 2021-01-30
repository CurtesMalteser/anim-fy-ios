//
//  AppInjector.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

import Foundation

class AppInjector {

    private var detailsViewModel: DetailsViewModel? = nil

    let animeRepository = AnimeRepository()
    let mangaRepository = MangaRepository()

    func injectDetailsViewModel(repositoryType type: DataRepositoryType) -> DetailsViewModel {
        if let detailsViewModel = detailsViewModel {
            return detailsViewModel
        } else {
            if (type == .anime) {
                detailsViewModel = DetailsViewModel(dataRepository: animeRepository)
            } else if (type == .manga) {
                detailsViewModel = DetailsViewModel(dataRepository: mangaRepository)
            }
            return detailsViewModel!
        }
    }

    func destroyDetailsViewModel() {
        detailsViewModel = nil
    }
}
