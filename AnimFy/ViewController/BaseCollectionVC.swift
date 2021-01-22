//
//  BaseCollectionVC.swift.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire
import Kingfisher

class BaseCollectionVC: UICollectionViewController {

    var dataList: [DataCellModel] = []

    var delegate: BaseCollectionDelegate!

    func downloadCollection(of type: AnimFyAPI) {

        showNetworkActivityAlert { controller in

            AF.request(type).responseJSON { [self] response in

                switch response.result {
                case .success(_):

                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(AnimeData.self, from: response.data!)
                        print(data.data.count)

                        dataList = data.data.map { datum -> DataCellModel in
                            DataCellModel(
                                    id: datum.id, title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                    imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large)
                            )
                        }

                        delegate.reloadData()

                        controller.dismiss(animated: false)

                    } catch {
                        print("error: \(error)")
                        self.showErrorAlert(message: error.localizedDescription) {
                            controller.dismiss(animated: false)
                        }
                    }

                case .failure(let error):
                    self.showErrorAlert(message: error.localizedDescription) {
                        controller.dismiss(animated: false)
                    }
                    print(error.localizedDescription)

                }

            }
        }
    }

    func tryGetImageURL(link: String?) -> URL? {
        if let link = link {
            return URL(string: link)
        } else {
            return nil
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.identifier, for: indexPath) as! PosterViewCell
        if let imageURL = dataList[indexPath.row].imageURL {
            cell.posterView.kf.setImage(with: imageURL, placeholder: UIImage.imagePlaceholder())
        } else {
            cell.posterView.image = UIImage.imagePlaceholder()
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = dataList[indexPath.row].title
        print("title: \(title) row \(indexPath.row)")
    }

    func setCollectionViewCellDimensions(collectionView view: UIView, flowLayout: UICollectionViewFlowLayout) {

        //let space: CGFloat = 3
        //let numberOfItemsPerRow: CGFloat = 3
//
        //let dimension = (view.frame.size.width - (space * (numberOfItemsPerRow - 1))) / numberOfItemsPerRow
//
        //flowLayout.minimumInteritemSpacing = space
        //flowLayout.minimumLineSpacing = space
        //flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

}

protocol BaseCollectionDelegate {
    var dataRepository: DataRepositoryProtocol { get }
    func reloadData()
}

