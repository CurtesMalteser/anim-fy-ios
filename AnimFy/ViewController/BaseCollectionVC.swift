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

    var dataList: [AnimeDatum] = []

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

                        dataList = data.data
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.identifier, for: indexPath) as! PosterViewCell

        if let cover = dataList[indexPath.row].attributes.posterImage {
            if let link = cover.large {
                let url = URL(string: link)
                cell.posterView.kf.setImage(with: url, placeholder: UIImage.imagePlaceholder())
            } else {
                cell.posterView.image = UIImage.imagePlaceholder()
            }
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = dataList[indexPath.row].attributes.titles.enJp
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
    func reloadData()
    //func dequeuePosterCell(cell: PosterViewCell)
}

