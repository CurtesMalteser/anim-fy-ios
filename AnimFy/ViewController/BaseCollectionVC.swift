//
//  BaseCollectionVC.swift.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import Alamofire

class BaseCollectionVC: UICollectionViewController {

    func downloadCollection(of type: AnimFyAPI) {

        showNetworkActivityAlert { controller in

            AF.request(type).responseJSON { response in

                switch response.result {
                case .success(_):

                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(Data.self, from: response.data!)
                        print(data)
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

}

