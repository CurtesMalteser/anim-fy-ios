//
//  AnimeRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Alamofire
import CoreData

class AnimeRepository: NSObject, DataRepositoryProtocol {

    let type: DataRepositoryType = .anime

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    private var animeDataList: [AnimeDatum] = []

    var dataList: [DataCellModel] = []

    var detailsSectionDictionary: Dictionary<String, Array<DetailsSectionProtocol>> = [:]

    private var _nextPageURL: String? = nil
    private var _lastPagerURL: String? = nil

    private let _dataController: DataController

    private var fetchedResultsController: NSFetchedResultsController<DatumDetails>!

    init(dataController: DataController) {
        _dataController = dataController
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
        detailsSectionDictionary[id]
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
                           initFetchPhotosController(id: datum.id)
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

    /**
     Initializes the fetchedResultsController and fetch the DatumDetails for datumID.
    */
    private func initFetchPhotosController(id: String) -> UserOptionRowModel {
        let fetchRequest: NSFetchRequest<DatumDetails> = DatumDetails.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "datumID == %@", id)

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datumID", ascending: false)]

        fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: _dataController.backgroundContext,
                sectionNameKeyPath: nil,
                cacheName: nil
        )

        fetchedResultsController.delegate = self

        var userOptionRowModel: UserOptionRowModel = UserOptionRowModel(favorite: false, forLater: false)

        fetchedResultsController.managedObjectContext.doTry(
                onSuccess: { context in
                    let result = try context.fetch(fetchRequest)

                    if let datumDetail = result.first {
                        userOptionRowModel = UserOptionRowModel(favorite: datumDetail.favorite, forLater: datumDetail.saveForLater)
                    }

                },
                onError: { error in
                    print("fetch result \(error.localizedDescription)")
                }
        )

        return userOptionRowModel
    }

/*    func deletePhoto(at indexPath: IndexPath) {

        showNetworkActivityAlert { [self] deletePhotoIndicator in
            context.doTry(onSuccess: { context in
                let photoToDelete = fetchedResultsController.object(at: indexPath)
                context.delete(photoToDelete)
                try context.save()
                deletePhotoIndicator.dismiss(animated: false)
            }, onError: { _ in
                showErrorAlert(message: deletePhotoErrorMessage) {
                    deletePhotoIndicator.dismiss(animated: false)
                }
            })
        }

    }*/

    func storeDatumDetailsFor(cell rowCell: UserOptionRowModel, datumID id: String) {

        if (rowCell.favorite == false && rowCell.forLater == false) {
            deletePhoto(datumID: id)
        } else {
            saveDatumDetailsFor(datumID: id, rowCell: rowCell)
        }

    }

    private func saveDatumDetailsFor(datumID id: String, rowCell: UserOptionRowModel) {
        if let datumDetails = getDatumDetailsBy(id: id) {

            let section = datumDetails.first { section in
                section is PosterSection
            } as! PosterSection

            let dataCell = section.rows.first { row in
                row is DataCellModel
            } as! DataCellModel
            // todo: Update dictionary if save the details succeed and notify the view model
            //detailsSectionDictionary[id] = datumDetails

            fetchedResultsController.managedObjectContext.doTry(onSuccess: { context in
                initializeDatumDetails(context: context, dataCell: dataCell, rowCell: rowCell)
                try context.save()
            }, onError: { error in
                print("Failed to store DatumDetails \(error)")
            })

        }
    }

    private func deletePhoto(datumID id: String) {

        print("deletePhoto: \(id)")

        let fetchRequest = fetchedResultsController.fetchRequest

        fetchRequest.predicate = NSPredicate(format: "datumID == %@", id)

        fetchedResultsController.managedObjectContext.doTry(onSuccess: { context in

            let result = try context.fetch(fetchRequest)
            result.forEach { result in
                context.doTry(onSuccess: { context in
                    context.delete(result)
                }, onError: { error in
                    print("Failed to delete DatumDetails \(error)")
                })
            }
        }, onError: { error in
            print("Failed to fetch DatumDetails to delete \(error)")
        })
    }

    private func initializeDatumDetails(context: NSManagedObjectContext, dataCell: DataCellModel, rowCell: UserOptionRowModel) {
        //print("dataCell: \(dataCell)")
        print("rowCell: \(rowCell)")
        let datum = DatumDetails(context: context)
        datum.datumType = type.rawValue
        datum.datumID = dataCell.datumID
        datum.imageURL = dataCell.imageURL
        datum.synopsys = dataCell.synopsis
        datum.title = dataCell.title
        datum.favorite = rowCell.favorite
        datum.saveForLater = rowCell.forLater
    }


}