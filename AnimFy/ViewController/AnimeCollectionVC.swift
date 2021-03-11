//
//  AnimeCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class AnimeCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet weak var animeCollectionView: UICollectionView!

    var collectionView: UICollectionView {
        get {
            animeCollectionView
        }
    }

    @IBOutlet weak var animeFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            setCollectionViewCellDimensions(collectionView: animeCollectionView, flowLayout: animeFlowLayout)
        }
    }

    var dataRepository: DataRepositoryProtocol?

    var successHandler: (DataRepositoryProtocol) -> Void = { dataRepository in
        if (dataRepository.dataList.count < 30) {
            dataRepository.downloadMoreCollection()
        }
    }

    let settingsLauncher = SettingsLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBarButton(selector: #selector(setupAnimeMenu))
        delegate = self
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).animeRepository
        dataRepository?.statusDelegate = statusDelegate

        settingsLauncher.viewModel = SettingsViewModel(rows: [

            SettingsRow(label: "Favorites", icon: UIImage.imageUserCount()) {
                self.presentFavoriteLaterVC(repoType: .favorite)
            },

            SettingsRow(label: "Watch later", icon: UIImage.imagePlaceholder()) {
                self.presentFavoriteLaterVC(repoType: .saveForLater)
            },

            SettingsRow(label: "Cancel", icon: UIImage(systemName: "xmark"), completion: nil)

        ])

    }

    private func presentFavoriteLaterVC(repoType: DataRepositoryType) {
        self.presentViewControllerWithInject(storyboard: self.storyboard,
                identifier: FavoritesLaterCollectionVC.identifier,
                navigationController: navigationController) { (vc: FavoritesLaterCollectionVC) in

            vc.dataRepository = (UIApplication.shared.delegate as! AppDelegate)
                    .injectStoredDatumRepository(repositoryType: repoType, queryType: dataRepository!.type)

        }
    }

    @objc private func setupAnimeMenu() {
        settingsLauncher.showSettings()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

}
