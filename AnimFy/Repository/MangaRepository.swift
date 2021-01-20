//
//  MangaRepository.swift
//  AnimFy
//
//  Created by António Bastião on 20.01.21.
//

import Foundation

import Alamofire

class MangaRepository: DataRepositoryProtocol {

    var dataList: [DataCellModel] = []

    func downloadCollection() {
        AF.request(AnimFyAPI.manga).responseJSON { [self] response in

            switch response.result {
            case .success(_):

                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(MangaData.self, from: response.data!)
                    print(data.data.count)

                    dataList = data.data.map { datum -> DataCellModel in
                        DataCellModel(
                                id: datum.id, title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large)
                        )
                    }



                } catch {

                }

            case .failure(let error):

                print(error.localizedDescription)

            }

        }

    }

    func getDataCellModel() -> Array<DataCellModel> {
        dataList
    }
}
