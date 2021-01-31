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


    func downloadCollection() {

        if (isInProgress || !dataList.isEmpty) {
            return
        }

        statusDelegate.postStatus(.Loading)

        mockAnimeResponse()

        AF.request(AnimFyAPI.anime).responseJSON { [self] response in
            isInProgress = true
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let stringResponse = String(decoding: data, as: UTF8.self)
                    print("data: \(stringResponse)")
                }

                do {

                    let decoder = JSONDecoder()
                    let data = try decoder.decode(AnimeData.self, from: response.data!)
                    print(data.data.count)

                    animeDataList = data.data
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

                if let data = response.data {
                    let stringResponse = String(decoding: data, as: UTF8.self)
                    print("data: \(stringResponse)")
                }

                mockAnimeResponse()
                setCompletedStatus(.Error(error: error))
            }

        }
    }

    func getDatumDetailsBy(id: String) {
        // todo
    }

    private func setCompletedStatus(_ status: Status) {
        isInProgress = false
        statusDelegate.postStatus(status)
    }

}

extension AnimeRepository {
    var response: String {
        get {
            """
            {
              "data": [
                {
                  "id": "1",
                  "type": "anime",
                  "links": {
                    "self": "https://kitsu.io/api/edge/anime/1"
                  },
                  "attributes": {
                    "createdAt": "2013-02-20T16:00:13.609Z",
                    "updatedAt": "2017-12-20T00:00:09.270Z",
                    "slug": "cowboy-bebop",
                    "synopsis": "In the year 2071, humanity has colonoized several of the planets and moons...",
                    "coverImageTopOffset": 400,
                    "titles": {
                      "en": "Cowboy Bebop",
                      "en_jp": "Cowbop Bebop",
                      "ja_jp": "カウボーイビバップ"
                    },
                    "canonicalTitle": "Cowboy Bebop",
                    "abbreviatedTitles": [
                      "COWBOY BEBOP"
                    ],
                    "averageRating": "88.55",
                    "ratingFrequencies": {
                      "2": "83",
                      "3": "0",
                      "4": "296",
                      "5": "0",
                      "6": "67",
                      "7": "2",
                      "8": "200",
                      "9": "1",
                      "10": "271",
                      "11": "3",
                      "12": "1414",
                      "13": "11",
                      "14": "1709",
                      "15": "35",
                      "16": "3917",
                      "17": "56",
                      "18": "4638",
                      "19": "69",
                      "20": "14276"
                    },
                    "userCount": 43409,
                    "favoritesCount": 3485,
                    "startDate": "1998-04-03",
                    "endDate": "1999-04-24",
                    "popularityRank": 10,
                    "ratingRank": 10,
                    "ageRating": "R",
                    "ageRatingGuide": "17+ (violence & profanity)",
                    "subtype": "TV",
                    "status": "finished",
                    "tba": "",
                    "posterImage": {
                      "tiny": "https://media.kitsu.io/anime/poster_images/1/tiny.jpg?1431697256",
                      "small": "https://media.kitsu.io/anime/poster_images/1/small.jpg?1431697256",
                      "medium": "https://media.kitsu.io/anime/poster_images/1/medium.jpg?1431697256",
                      "large": "https://media.kitsu.io/anime/poster_images/1/large.jpg?1431697256",
                      "original": "https://media.kitsu.io/anime/poster_images/1/original.jpg?1431697256",
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
                      "tiny": "https://media.kitsu.io/anime/cover_images/1/tiny.jpg?1416336000",
                      "small": "https://media.kitsu.io/anime/cover_images/1/small.jpg?1416336000",
                      "large": "https://media.kitsu.io/anime/cover_images/1/large.jpg?1416336000",
                      "original": "https://media.kitsu.io/anime/cover_images/1/original.jpg?1416336000",
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
                    "episodeCount": 26,
                    "episodeLength": 25,
                    "youtubeVideoId": "qig4KOK2R2g",
                    "showType": "TV",
                    "nsfw": false
                  },
                  "relationships": {
                    "genres": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/genres",
                        "related": "https://kitsu.io/api/edge/anime/1/genres"
                      }
                    },
                    "categories": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/categories",
                        "related": "https://kitsu.io/api/edge/anime/1/categories"
                      }
                    },
                    "castings": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/castings",
                        "related": "https://kitsu.io/api/edge/anime/1/castings"
                      }
                    },
                    "installments": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/installments",
                        "related": "https://kitsu.io/api/edge/anime/1/installments"
                      }
                    },
                    "mappings": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/mappings",
                        "related": "https://kitsu.io/api/edge/anime/1/mappings"
                      }
                    },
                    "reviews": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/reviews",
                        "related": "https://kitsu.io/api/edge/anime/1/reviews"
                      }
                    },
                    "mediaRelationships": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/media-relationships",
                        "related": "https://kitsu.io/api/edge/anime/1/media-relationships"
                      }
                    },
                    "episodes": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/episodes",
                        "related": "https://kitsu.io/api/edge/anime/1/episodes"
                      }
                    },
                    "streamingLinks": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/streaming-links",
                        "related": "https://kitsu.io/api/edge/anime/1/streaming-links"
                      }
                    },
                    "animeProductions": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/anime-productions",
                        "related": "https://kitsu.io/api/edge/anime/1/anime-productions"
                      }
                    },
                    "animeCharacters": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/anime-characters",
                        "related": "https://kitsu.io/api/edge/anime/1/anime-characters"
                      }
                    },
                    "animeStaff": {
                      "links": {
                        "self": "https://kitsu.io/api/edge/anime/1/relationships/anime-staff",
                        "related": "https://kitsu.io/api/edge/anime/1/anime-staff"
                      }
                    }
                  }
                }
              ],
              "meta": {
                "count": 13797
              },
              "links": {
                "first": "https://kitsu.io/api/edge/anime?page%5Blimit%5D=10&page%5Boffset%5D=0",
                "prev": "https://kitsu.io/api/edge/anime?page%5Blimit%5D=10&page%5Boffset%5D=0",
                "next": "https://kitsu.io/api/edge/anime?page%5Blimit%5D=10&page%5Boffset%5D=10",
                "last": "https://kitsu.io/api/edge/anime?page%5Blimit%5D=10&page%5Boffset%5D=13787"
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

    func mockAnimeResponse() {

        do {

            let decoder = JSONDecoder()
            let data = try decoder.decode(AnimeData.self, from: self.data)

            print(data.data.count)

            animeDataList = data.data
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

    }
}
