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


    func injectDetailsViewModel() -> DetailsViewModel{
        if let detailsViewModel = detailsViewModel {
            return detailsViewModel
        } else {
            detailsViewModel = DetailsViewModel()
            return detailsViewModel!
        }
    }
}
