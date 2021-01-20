
//
//  AnimeRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Alamofire

class AnimeRepository: DataRepositoryProtocol {

    private var _dataList: [DataCellModel] = []
    var dataList: [DataCellModel] {
        get { getDataCellModel() }
        set { _dataList = newValue}
    }

    func downloadCollection() {
        AF.request(AnimFyAPI.anime).responseJSON { [self] response in

            // todo -> post loading status

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


                // todo -> Post Success


                } catch {
                // todo -> Post error

                }

            case .failure(let error):
                // todo -> Post error
                print(error.localizedDescription)

            }

        }

    }

    private func getDataCellModel() -> Array<DataCellModel> {
        if (!_dataList.isEmpty){
            return _dataList
        } else {
            downloadCollection()
            return _dataList
        }
    }
}
