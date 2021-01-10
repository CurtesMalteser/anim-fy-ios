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
        AF.request(type).responseJSON { response in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                print(response)
            }
        }
    }

}

