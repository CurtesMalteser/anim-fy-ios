//
//  MangaRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

import Alamofire

class MangaRepository: DataRepositoryProtocol {

    let type: DataRepositoryType = .manga

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    private var mangaDataList: [MangaDatum] = []

    var dataList: [DataCellModel] = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]

    func downloadCollection() {

        if (isInProgress || !dataList.isEmpty) {
            return
        }

        statusDelegate.postStatus(.Loading)

        AF.request(AnimFyAPI.manga).responseJSON { [self] response in
            isInProgress = true
            switch response.result {
            case .success(_):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(MangaData.self, from: response.data!)
                    print(data.data.count)

                    mangaDataList = data.data
                    dataList = data.data.map { datum -> DataCellModel in

                        let dataCell = DataCellModel(
                                datumID: datum.id,
                                title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                                synopsis: datum.attributes.synopsis
                        )

                        composeMangaDetailRows(datum: datum as MangaDatum, dataCell: dataCell)

                        return dataCell
                    }

                    setCompletedStatus(.Success)
                } catch {
                    setCompletedStatus(.Error(error: error))

                }

            case .failure(let error):
                setCompletedStatus(.Error(error: error))
            }

        }
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        detailsSectionDictionary[id]
    }

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }

    private func composeMangaDetailRows(datum: MangaDatum, dataCell: DataCellModel) {

        let attrs = datum.attributes

        let chapterCount: String = attrs.optionalAttrToString { (attributes: MangaAttributes) in
            attributes.chapterCount != nil ? String(attributes.chapterCount!) : "N/A"
        }

        let volumeCount: String = attrs.optionalAttrToString { (attributes: MangaAttributes) in
            attributes.volumeCount != nil ? String(attributes.volumeCount!) : "N/A"
        }

        detailsSectionDictionary[datum.id] = [
            PosterSection(
                    label: attrs.titles.en ?? attrs.titles.enJp,
                    rows: [dataCell]),
            AttributesSection(
                    rows: [
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Anime type", value: datum.type),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Status", value: attrs.status.rawValue),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Number of Chapter", value: chapterCount),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Number of Volumes", value: volumeCount),
                        RatingRow(icon: UIImage.imageUserCount(), title: "User Count", value: String(attrs.userCount)),
                        RatingRow(icon: UIImage.imageFavoritesCount(), title: "Favorites Count", value: String(attrs.favoritesCount)),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Popularity Rank", value: String(attrs.popularityRank)),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Rating Rank", value: String(format: "%d", attrs.ratingRank ?? "N/A")),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Age Rating", value: attrs.optionalAgeRatingToString()),
                        RatingRow(icon: UIImage.imagePlaceholder(), title: "Age Rating Guide", value: attrs.optionalAgeRatingGuideToString()),
                    ])
        ]
    }
}
