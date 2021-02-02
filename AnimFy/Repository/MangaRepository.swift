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

                        detailsSectionDictionary[datum.id] = [
                            PosterSection(
                                    // fixme -> title not needed on DataCell this way
                                    label: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                    rows: [dataCell]),
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
