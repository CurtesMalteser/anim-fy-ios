//
//  BaseCollectionVC.swift.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Kingfisher

class BaseCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, StatusDelegateProtocol {

    var delegate: BaseCollectionDelegate!

    var networkActivityIndicator: UIAlertController? = nil

    lazy var statusDelegate: StatusDelegateProtocol = self

    func setUpNavBarButton(selector: Selector) {
        let optionsButton = UIBarButtonItem(image: UIImage.imageShowMore(), style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem = optionsButton
    }

    func postStatus(_ status: Status) {
        print("status: \(status)")
        switch (status) {
        case .Success:
            delegate.reloadData()
            networkActivityIndicator?.dismiss(animated: true)

        case .Loading:
            networkActivityIndicator = showNetworkActivityAlert()

        case .Error(let error):
            networkActivityIndicator?.dismiss(animated: true) {
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }

    func downloadCollection() {
        delegate.dataRepository!.downloadCollection()
    }

    func tryGetImageURL(link: String?) -> URL? {
        if let link = link {
            return URL(string: link)
        } else {
            return nil
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.identifier, for: indexPath) as! PosterViewCell
        if let imageURL = delegate.dataRepository!.dataList[indexPath.row].imageURL {
            cell.posterView.kf.setImage(with: imageURL, placeholder: UIImage.imagePlaceholder())
        } else {
            cell.posterView.image = UIImage.imagePlaceholder()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        delegate.dataRepository!.dataList.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = delegate.dataRepository!.dataList[indexPath.row].datumID
        pushDetailsVC(datumID: id)
    }

    func setCollectionViewCellDimensions(collectionView view: UIView, flowLayout: UICollectionViewFlowLayout) {

        let space: CGFloat = 3
        let numberOfItemsPerRow: CGFloat = 3

        let dimension = (view.frame.size.width - (space * (numberOfItemsPerRow - 1))) / numberOfItemsPerRow

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

    }

    private func pushDetailsVC(datumID id: String) {
        pushViewControllerWithInject(storyboard: storyboard,
                identifier: DetailsVC.identifier,
                navigationController: navigationController) { viewController in

            let detailsVC = viewController as! DetailsVC

            detailsVC.datumID = id
            detailsVC.dataRepositoryType = delegate.dataRepository?.type

        }

    }

}

protocol BaseCollectionDelegate {
    var dataRepository: DataRepositoryProtocol? { get }
    func reloadData()
}

