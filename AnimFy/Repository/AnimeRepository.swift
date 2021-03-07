//
//  AnimeRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Alamofire
import CoreData

class AnimeRepository: NSObject, DataRepositoryProtocol {

    let type: DataRepositoryType

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    private var animeDataList: [AnimeDatum] = []

    var dataList: [DataCellModel] = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> {
        get {
            _mapper.detailsSectionDictionary

        }
        set {
            _mapper.detailsSectionDictionary = newValue
        }
    }

    private var _nextPageURL: String? = nil
    private var _lastPagerURL: String? = nil

    private let _mapper: DataRepositoryMapper

    init(repositoryType: DataRepositoryType, mapper: DataRepositoryMapper) {
        type = repositoryType
        _mapper = mapper
    }


    func downloadCollection() {

        if (isInProgress || !dataList.isEmpty) {
            return
        }

        setDownloadStarted()

        AF.request(AnimFyAPI.anime).responseJSON { [self] response in
            switch response.result {
            case .success(_):
                do {

                    let decoder = JSONDecoder()
                    let data = try decoder.decode(AnimeData.self, from: response.data!)
                    print(data.data.count)

                    _nextPageURL = data.links.next
                    _lastPagerURL = data.links.last

                    animeDataList = data.data
                    dataList = data.data.map { datum -> DataCellModel in

                        let dataCell = DataCellModel(
                                datumID: datum.id,
                                title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                                synopsis: datum.attributes.synopsis
                        )

                        composeAnimeDetailRows(datum: datum, dataCell: dataCell)


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

    func downloadMoreCollection() {

        if (isInProgress) {
            return
        }

        if let nextPage = _nextPageURL {

            setDownloadStarted()

            do {

                let request = try AnimFyAPI.pagination.parameterisedURLRequest(url: nextPage)

                AF.request(request).responseJSON { [self] response in
                    switch response.result {
                    case .success(_):

                        do {

                            let decoder = JSONDecoder()
                            let data = try decoder.decode(AnimeData.self, from: response.data!)

                            _nextPageURL = data.links.next
                            _lastPagerURL = data.links.last


                            animeDataList.append(contentsOf: data.data)

                            let newDataList = data.data.map { datum -> DataCellModel in

                                let dataCell = DataCellModel(
                                        datumID: datum.id,
                                        title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                        imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                                        synopsis: datum.attributes.synopsis
                                )

                                composeAnimeDetailRows(datum: datum, dataCell: dataCell)


                                return dataCell

                            }

                            dataList.append(contentsOf: newDataList)

                            setCompletedStatus(.Success)

                        } catch {

                            setCompletedStatus(.Error(error: error))

                        }

                    case .failure(let error):

                        setCompletedStatus(.Error(error: error))

                    }
                }
            } catch {

                setCompletedStatus(.Error(error: error))

            }
        }
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>? {
        _mapper.getDatumDetailsBy(id: id)
    }

    private func setDownloadStarted() {
        statusDelegate.postStatus(.Loading)
        isInProgress = true
    }

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }

    private func composeAnimeDetailRows(datum: AnimeDatum, dataCell: DataCellModel) {

        let attrs = datum.attributes

        let episodeCount: String = attrs.optionalAttrToString { (attributes: AnimeAttributes) in
            attributes.episodeCount != nil ? String(attributes.episodeCount!) : "N/A"
        }

        detailsSectionDictionary[datum.id] = [
            PosterSection(
                    label: attrs.titles.en ?? attrs.titles.enJp,
                    rows: [dataCell,
                           _mapper.initUserOptionRowModel(id: datum.id)
                    ]),
            AttributesSection(
                    rows: [
                        RatingRow(icon: UIImage.imageAnime(), title: "Anime type", value: datum.type.rawValue),
                        RatingRow(icon: UIImage.imageStatus(), title: "Status", value: attrs.status.rawValue),
                        RatingRow(icon: UIImage.imageAnimeEpisodes(), title: "Number of Episodes", value: episodeCount),
                        RatingRow(icon: UIImage.imageUserCount(), title: "User Count", value: String(attrs.userCount)),
                        RatingRow(icon: UIImage.imageFavoritesCount(), title: "Favorites Count", value: String(attrs.favoritesCount)),
                        RatingRow(icon: UIImage.imagePopularityRank(), title: "Popularity Rank", value: String(attrs.popularityRank)),
                        RatingRow(icon: UIImage.imageRatingRank(), title: "Rating Rank", value: attrs.optionalRatingRankToString()),
                        RatingRow(icon: UIImage.imageAgeRating(), title: "Age Rating", value: attrs.optionalAgeRatingToString()),
                        RatingRow(icon: UIImage.imageInfo(), title: "Age Rating Guide", value: attrs.optionalAgeRatingGuideToString()),
                    ])
        ]
    }

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {
        _mapper.storeDatumDetailsFor(cell: rowCell, datumID: id)
    }


}