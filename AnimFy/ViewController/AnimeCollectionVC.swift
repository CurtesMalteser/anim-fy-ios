//
//  AnimeCollectionVC.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class AnimeCollectionVC: BaseCollectionVC, BaseCollectionDelegate {

    @IBOutlet var animeCollectionView: UICollectionView!

    @IBOutlet weak var animeFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            setCollectionViewCellDimensions(collectionView: animeCollectionView, flowLayout: animeFlowLayout)
        }
    }

    var dataRepository: DataRepositoryProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBarButton(selector: #selector(setupAnimeMenu))
        delegate = self
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        dataRepository = (UIApplication.shared.delegate as! AppDelegate).animeRepository
        dataRepository?.statusDelegate = statusDelegate
    }

    /// source: https://www.youtube.com/watch?v=2kwCfFG5fDA
    @objc private func setupAnimeMenu() {
        print("more anime")

        if let window = UIApplication.firstKeyWindow() {
            let blackView = UIView()
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0

            UIView.animate(withDuration: 0.6) {
                blackView.alpha = 1
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadCollection()
    }

    func reloadData() {
        animeCollectionView.reloadData()
    }
}
