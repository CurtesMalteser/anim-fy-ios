//
//  AnimeRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Alamofire

class AnimeRepository: DataRepositoryProtocol {

    let type: DataRepositoryType = .anime

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    private var animeDataList: [AnimeDatum] = []

    var dataList: [DataCellModel] = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]

    func downloadCollection() {

        if (isInProgress || !dataList.isEmpty) {
            return
        }

        statusDelegate.postStatus(.Loading)

        AF.request(AnimFyAPI.anime).responseJSON { [self] response in
            isInProgress = true
            switch response.result {
            case .success(_):
                do {

                    let decoder = JSONDecoder()
                    let data = try decoder.decode(AnimeData.self, from: response.data!)
                    print(data.data.count)

                    animeDataList = data.data
                    dataList = data.data.map { datum -> DataCellModel in

                        let dataCell = DataCellModel(
                                datumID: datum.id,
                                title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                                synopsis: datum.attributes.synopsis
                        )

                        let attrs = datum.attributes
                        detailsSectionDictionary[datum.id] = [
                            PosterSection(
                                    label: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                    rows: [dataCell]),
                            AttributesSection(
                                    rows: [
                                RatingRow(userCount: attrs.userCount,
                                        favoritesCount: attrs.favoritesCount,
                                        popularityRank: attrs.popularityRank,
                                        ratingRank: attrs.ratingRank,
                                        ageRating: attrs.ageRating)
                            ])
                        ]


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

}