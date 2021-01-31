//
//  DetailsTableDataSourceDelegate.swift
//  AnimFy
//
//  Created by António Bastião on 31.01.21.
//

import Foundation
import UIKit
import Kingfisher

class DetailsTableDataSourceDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var _viewModel: DetailsViewModel!


    init(detailsViewModel: DetailsViewModel) {
        print("AJDB -> init delegate")

        _viewModel = detailsViewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let viewCell = tableView.dequeueReusableCell(withIdentifier: DetailsViewCell.identifier, for: indexPath) as! DetailsViewCell
        viewCell.label.text = _viewModel.dataCell?.title
        viewCell.synopsis.text = "Once upon a time..."
        return viewCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       200
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {


        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PosterDetailsHeaderView.identifier) as! PosterDetailsHeaderView

        if let cell = _viewModel.dataCell {
            if let imageURL = cell.imageURL {
                headerView.poster.kf.setImage(with: imageURL, placeholder: UIImage.imagePlaceholder())
            }
        }

        return headerView
    }
}
