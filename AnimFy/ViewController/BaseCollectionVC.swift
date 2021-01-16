//
//  BaseCollectionVC.swift.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class BaseCollectionVC: UICollectionViewController {

    var dataList: [Datum] = []

    var delegate: BaseCollectionDelegate!

    func downloadCollection(of type: AnimFyAPI) {

        showNetworkActivityAlert { controller in

            AF.request(type).responseJSON { [self] response in

                switch response.result {
                case .success(_):

                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(Data.self, from: response.data!)
                        print(data)

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
        super.collectionView(collectionView, cellForItemAt: indexPath)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.identifier, for: indexPath) as! PosterViewCell

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        super.collectionView(_: collectionView, numberOfItemsInSection: section)
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didDeselectItemAt: indexPath)
    }

    func setCollectionViewCellDimensions(collectionView: UICollectionView, flowLayout: UICollectionViewFlowLayout) {

        let space: CGFloat = 3
        let numberOfItemsPerRow: CGFloat = 3

        let dimension = (collectionView.frame.size.width - (space * (numberOfItemsPerRow - 1))) / numberOfItemsPerRow

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

}

protocol BaseCollectionDelegate {
    func reloadData()
}

