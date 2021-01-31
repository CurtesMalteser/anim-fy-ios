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

                        let dataCell =  DataCellModel(
                                id: datum.id, title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                                imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                                synopsis: datum.attributes.synopsis
                        )

                        detailsSectionDictionary[datum.id] = [
                            dataCell
                        ]

                        return dataCell
                    }

                    setCompletedStatus(.Success)
                } catch {
                    setCompletedStatus(.Error(error: error))

                }

            case .failure(let error):

                mockMangaResponse()
                setCompletedStatus(.Error(error: error))

            }

        }
    }

    func getDatumDetailsBy(id: String) -> Array<DetailsSectionProtocol>?{
        detailsSectionDictionary[id]
    }

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }
}

extension MangaRepository {
    var response: String {
        get {
            """
            {
              "data": [
                {
                  "id": "14916",
                  "type": "manga",
                  "links": {
                    "self": "https://kitsu.io/api/edge/manga/14916"
                  },
                  "attributes": {
                    "createdAt": "2013-12-18T13:59:39.232Z",
                    "updatedAt": "2017-12-24T00:00:19.819Z",
                    "slug": "shingeki-no-kyojin",
                    "synopsis": "Several hundred years ago...",
                    "coverImageTopOffset": 112,
                    "titles": {
                      "en": "Attack on Titan",
                      "en_jp": "Shingeki no Kyojin",
                      "ja_jp": "進撃の巨人"
                    },
                    "canonicalTitle": "Attack on Titan",
                    "abbreviatedTitles": null,
                    "averageRating": "82.47",
                    "ratingFrequencies": {
                      "2": "39",
                      "3": "0",
                      "4": "18",
                      "5": "0",
                      "6": "27",
                      "7": "4",
                      "8": "126",
                      "9": "0",
                      "10": "85",
                      "11": "4",
                      "12": "192",
                      "13": "5",
                      "14": "635",
                      "15": "3",
                      "16": "528",
                      "17": "12",
                      "18": "534",
                      "19": "2",
                      "20": "1379"
                    },
                    "userCount": 7137,
                    "favoritesCount": 758,
                    "startDate": "2009-09-09",
                    "endDate": null,
                    "popularityRank": 2,
                    "ratingRank": 138,
                    "ageRating": "R",
                    "ageRatingGuide": "Horror",
                    "subtype": "manga",
                    "status": "finished",
                    "tba": "",
                    "posterImage": {
                      "tiny": "https://media.kitsu.io/manga/poster_images/14916/tiny.jpg?1491099787",
                      "small": "https://media.kitsu.io/manga/poster_images/14916/small.jpg?1491099787",
                      "medium": "https://media.kitsu.io/manga/poster_images/14916/medium.jpg?1491099787",
                      "large": "https://media.kitsu.io/manga/poster_images/14916/large.jpg?1491099787",
                      "original": "https://media.kitsu.io/manga/poster_images/14916/original.jpg?1491099787",
                      "meta": {
                        "dimensions": {
                          "tiny": {
                            "width": null,
                            "height": null
                          },
                          "small": {
                            "width": null,
                            "height": null
                          },
                          "medium": {
                            "width": null,
                            "height": null
                          },
                          "large": {
                            "width": null,
                            "height": null
                          }
                        }
                      }
                    },
                    "coverImage": {
                      "tiny": "https://media.kitsu.io/manga/cover_images/14916/tiny.jpg?1471880895",
                      "small": "https://media.kitsu.io/manga/cover_images/14916/small.jpg?1471880895",
                      "large": "https://media.kitsu.io/manga/cover_images/14916/large.jpg?1471880895",
                      "original": "https://media.kitsu.io/manga/cover_images/14916/original.jpg?1471880895",
                      "meta": {
                        "dimensions": {
                          "tiny": {
                            "width": null,
                            "height": null
                          },
                          "small": {
                            "width": null,
                            "height": null
                          },
                          "large": {
                            "width": null,
                            "height": null
                          }
                        }
                      }
                    },
                    "chapterCount": null,
                    "volumeCount": 0,
                    "serialization": "Bessatsu Shounen Magazine",
                    "mangaType": "manga"
                  },
                  "relationships": {
                    "genres": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/genres",
                        "related": "https://kitsu.io/api/edge/manga/1/genres"
                      }
                    },
                    "categories": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/categories",
                        "related": "https://kitsu.io/api/edge/manga/1/categories"
                      }
                    },
                    "castings": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/castings",
                        "related": "https://kitsu.io/api/edge/manga/1/castings"
                      }
                    },
                    "installments": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/installments",
                        "related": "https://kitsu.io/api/edge/manga/1/installments"
                      }
                    },
                    "mappings": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/mappings",
                        "related": "https://kitsu.io/api/edge/manga/1/mappings"
                      }
                    },
                    "reviews": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/reviews",
                        "related": "https://kitsu.io/api/edge/manga/1/reviews"
                      }
                    },
                    "mediaRelationships": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/media-relationships",
                        "related": "https://kitsu.io/api/edge/manga/1/media-relationships"
                      }
                    },
                    "chapters": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/chapters",
                        "related": "https://kitsu.io/api/edge/manga/1/chapters"
                      }
                    },
                    "mangaCharacters": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/manga-characters",
                        "related": "https://kitsu.io/api/edge/manga/1/manga-characters"
                      }
                    },
                    "mangaStaff": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/manga/1/relationships/manga-staff",
                        "related": "https://kitsu.io/api/edge/manga/1/manga-staff"
                      }
                    }
                  }
                }
              ],
              "meta": {
                "count": 40278
              },
              "links": {
                "first": "https://kitsu.io/api/edge/manga?page%5Blimit%5D=10&page%5Boffset%5D=0",
                "prev": "https://kitsu.io/api/edge/manga?page%5Blimit%5D=10&page%5Boffset%5D=0",
                "next": "https://kitsu.io/api/edge/manga?page%5Blimit%5D=10&page%5Boffset%5D=10",
                "last": "https://kitsu.io/api/edge/manga?page%5Blimit%5D=10&page%5Boffset%5D=40268"
              }
            }
            """
        }
    }

    var data: Data {
        get {
            response.data(using: .utf8)!
        }
    }

    func mockMangaResponse() {

        do {

            let decoder = JSONDecoder()
            let data = try decoder.decode(MangaData.self, from: self.data)

            print(data.data.count)

            mangaDataList = data.data
            dataList = data.data.map { datum -> DataCellModel in
                let dataCell = DataCellModel(
                        id: datum.id, title: datum.attributes.titles.en ?? datum.attributes.titles.enJp,
                        imageURL: tryGetImageURL(link: datum.attributes.posterImage?.large),
                        synopsis: datum.attributes.synopsis
                )

                detailsSectionDictionary[datum.id] = [
                    dataCell
                ]

                return  dataCell
            }
            setCompletedStatus(.Success)
        } catch {
            setCompletedStatus(.Error(error: error))

        }

    }
}

