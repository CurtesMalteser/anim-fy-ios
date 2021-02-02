//
//  DetailsVC.swift
//  AnimFy
//
//  Created by António Bastião on 24.01.21.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {

    static let identifier: String = "DetailsVC"

    var datumID: String!

    var dataRepositoryType: DataRepositoryType!


    var viewModel: DetailsViewModel {
        get {
            (UIApplication.shared.delegate as! AppDelegate).injectDetailsViewModel(datumID: self.datumID, repositoryType: dataRepositoryType)
        }
    }

    lazy var dataSource: DetailsTableDataSourceDelegate = DetailsTableDataSourceDelegate(detailsViewModel: viewModel)


    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.register(
                UINib(nibName: "PosterDetailsHeaderView", bundle: nil),
               forHeaderFooterViewReuseIdentifier: PosterDetailsHeaderView.identifier)

        tableView.register(
                UINib(nibName: "AttributesSectionHeaderView", bundle: nil),
                forHeaderFooterViewReuseIdentifier: AttributesSectionHeaderView.identifier)

        tableView.register(
                UINib(nibName: "DetailsViewCell", bundle: nil),
                forCellReuseIdentifier: DetailsViewCell.identifier)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = dataSource
        tableView.dataSource = dataSource

    }

    deinit {
        (UIApplication.shared.delegate as! AppDelegate).destroyDetailsViewModel()
    }
}
