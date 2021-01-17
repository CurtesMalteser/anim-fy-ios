//
//  Manga.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly. https://app.quicktype.io/


import Foundation

// MARK: - MangaData
struct MangaData: Codable {
    let data: [MangaDatum]
    let meta: Meta
    let links:Links
}

// MARK: - MangaDatum
struct MangaDatum: Datum {
    let id: String
    let type: String
    let links: DatumLinks
    let attributes: MangaAttributes
    let relationships: [String: Relationship]
}

// MARK: - MangaAttributes
struct MangaAttributes: Attributes {
    let createdAt: String
    let updatedAt: String
    let slug, synopsis: String
    let titles: Titles
    let canonicalTitle: String
    let abbreviatedTitles: [String]
    let averageRating: String?
    let ratingFrequencies: [String: String]
    let userCount, favoritesCount: Int
    let startDate, endDate: String?
    let popularityRank: Int
    let ratingRank: Int?
    let ageRating: AgeRating?
    let ageRatingGuide: String?
    let subtype: MangaTypeEnum
    let status: Status
    let tba: String?
    let posterImage: PosterImage?
    let coverImage: CoverImage?
    let chapterCount: Int?
    let volumeCount: Int?
    let serialization: String?
}

enum MangaTypeEnum: String, Codable {
    case doujin = "doujin"
    case manga = "manga"
    case manhua = "manhua"
    case manhwa = "manhwa"
    case novel = "novel"
    case oel = "oel"
    case oneshot = "oneshot"
}