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

    private var viewModel: DetailsViewModel? {
        get {
            (UIApplication.shared.delegate as! AppDelegate).injectDetailsViewModel(repositoryType: dataRepository.type)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let cell = viewModel?.getData(datumID: datumID) {
            print("message: \(cell.title)")
        }
    }

    deinit {
        (UIApplication.shared.delegate as! AppDelegate).destroyDetailsViewModel()
    }
}
