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
        _viewModel = detailsViewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        _viewModel.dataCell.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _viewModel.dataCell[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = _viewModel.dataCell[indexPath.section]

        switch section {
        case is PosterSection:
            let viewCell = tableView.dequeueReusableCell(withIdentifier: TitleSynopsisViewCell.identifier, for: indexPath) as! TitleSynopsisViewCell
            let cellModel = (section as! PosterSection).rows[indexPath.row] as! DataCellModel
            viewCell.title.text = cellModel.title
            viewCell.synopsis.text = cellModel.synopsis
            return viewCell

        case is AttributesSection:
            let viewCell = tableView.dequeueReusableCell(withIdentifier: DetailsViewCell.identifier, for: indexPath) as! DetailsViewCell
            let cellModel = (section as! AttributesSection).rows[indexPath.row] as! RatingRow
            viewCell.label.text = cellModel.title
            viewCell.value.text = cellModel.value
            viewCell.icon.image = UIImage.imagePlaceholder()
            return viewCell

        default:
            let viewCell = tableView.dequeueReusableCell(withIdentifier: DetailsViewCell.identifier, for: indexPath) as! DetailsViewCell
            viewCell.label.text = "N/A"
            viewCell.value.text = "N/A"
            return viewCell

        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeader = _viewModel.dataCell[section]
        switch sectionHeader {
        case is PosterSection:
            return 200
        default:
            return 44
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = _viewModel.dataCell[section]

        switch sectionHeader {
        case is PosterSection:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PosterDetailsHeaderView.identifier) as! PosterDetailsHeaderView
            let cell = sectionHeader as! PosterSection
            if let imageURL = (cell.rows.first as! DataCellModel).imageURL {
                headerView.poster.kf.setImage(with: imageURL, placeholder: UIImage.imagePlaceholder())
            }
            return headerView

        case is AttributesSection:
            return dequeueAttributesHeaderView(tableView: tableView, label: sectionHeader.label)

        default:
            return dequeueAttributesHeaderView(tableView: tableView, label: sectionHeader.label)
        }

    }

    private func dequeueAttributesHeaderView(tableView: UITableView, label: String) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AttributesSectionHeaderView.identifier) as! AttributesSectionHeaderView
        headerView.label.text = label
        return headerView
    }
}
