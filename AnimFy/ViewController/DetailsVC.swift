//
//  DetailsVC.swift
//  AnimFy
//
//  Created by António Bastião on 24.01.21.
//

import UIKit

class DetailsVC: UIViewController {

    static let identifier: String = "DetailsVC"

    var datumID: String!
    var dataRepository: DataRepositoryProtocol!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let viewModel = (UIApplication.shared.delegate as! AppDelegate).injectDetailsViewModel()
        print("message: \(viewModel.hello)")
    }
}
