//
//  AnimeRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Alamofire

class AnimeRepository: DataRepositoryProtocol {

    var statusDelegate: StatusDelegateProtocol!

    private var isInProgress = false

    var dataList: [DataCellModel] = []

    static func sharedInstance(statusDelegate: StatusDelegateProtocol) -> AnimeRepository {
        AnimeRepository(statusDelegate)
    }

    fileprivate init(_ statusDelegate: StatusDelegateProtocol) {
        self.statusDelegate = statusDelegate
    }


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

                    dataList = data.data.map { datum -> DataCellModel in
                        DataCellModel(
                                id: datum.id, title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large)
                        )
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

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }

}
