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

    let settingsLauncher = SettingsLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsLauncher.viewModel = SettingsViewModel(rows: [
            SettingsRow(label: "Favorites", icon: UIImage.imageUserCount()) {
                self.presentViewControllerWithInject(storyboard: self.storyboard,
                        identifier: FavoritesLaterCollectionVC.identifier,
                        navigationController: self.navigationController) { (vc: FavoritesLaterCollectionVC) in

                }
            },
            SettingsRow(label: "Watch later", icon: UIImage.imagePlaceholder()) {
                print("cell: Watch later")
            },
            SettingsRow(label: "Cancel", icon: UIImage(systemName: "xmark"), completion: nil)
        ]

        )

        setUpNavBarButton(selector: #selector(setupAnimeMenu))
        delegate = self
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).animeRepository
        dataRepository?.statusDelegate = statusDelegate
    }

    @objc private func setupAnimeMenu() {
        settingsLauncher.showSettings()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

}
