//
//  Anime.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly. https://app.quicktype.io/


import Foundation

// MARK: - AnimeData
struct AnimeData: Codable {
    let data: [AnimeDatum]
    let meta: Meta
    let links:Links
}

// MARK: - Datum
struct AnimeDatum: Codable {
    let id: String
    let type: AnimeTypeEnum
    let links: DatumLinks
    let attributes: AnimeAttributes
    let relationships: [String: Relationship]
}

// MARK: - Attributes
struct AnimeAttributes: Codable {
    let createdAt: String
    let updatedAt: String
    let slug, synopsis, attributesDescription: String
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
    let subtype: AnimeTypeEnum
    let status: Status
    let tba: String?
    let posterImage: PosterImage?
    let coverImage: CoverImage?
    let episodeCount: Int?
    let episodeLength: Int?
    let youtubeVideoId: String
    let nsfw: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, slug, synopsis
        case attributesDescription = "description"
        case titles,
             canonicalTitle,
             abbreviatedTitles,
             averageRating,
             ratingFrequencies,
             userCount,
             favoritesCount,
             startDate,
             endDate,
             popularityRank,
             ratingRank,
             ageRating,
             ageRatingGuide,
             subtype,
             status,
             tba,
             posterImage,
             coverImage,
             episodeCount,
             episodeLength,
             youtubeVideoId,
             nsfw
    }
}

protocol Image: Codable {
    var tiny: String? { get }
    var small: String? { get }
    var medium: String? { get }
    var large: String? { get }
    var original: String? { get }
}


// MARK: - PosterImage
struct PosterImage: Image {
    let tiny: String?
    let small: String?
    let medium: String?
    let large: String?
    let original: String?
    let posterImageMeta: ImageMeta

    enum CodingKeys: String, CodingKey {
        case tiny,
            small,
            medium,
            large,
            original
        case posterImageMeta = "meta"
    }
}

// MARK: - CoverImage
struct CoverImage: Image {
    var tiny: String?
    var small: String?
    var medium: String?
    var large: String?
    var original: String?
    var coverImageMeta: ImageMeta
    enum CodingKeys: String, CodingKey {
        case tiny,
             small,
             medium,
             large,
             original
        case coverImageMeta = "meta"
    }
}

// MARK: - ImageMeta
struct ImageMeta: Codable {
    let dimensions: Dimensions
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let tiny, small, medium, large: WidthAndHeight?
}

// MARK: - Large
struct WidthAndHeight: Codable {
    let width, height: Int?
}

enum AnimeTypeEnum: String, Codable {
    case anime = "anime"
    case ONA = "ONA"
    case OVA = "OVA"
    case TV = "TV"
    case movie = "movie"
    case music = "music"
    case special = "special"
}

enum AgeRating: String, Codable {
    case G = "G"
    case PG = "PG"
    case R = "R"
    case R18 = "R18"
}

enum Status: String, Codable {
    case current = "current"
    case finished = "finished"
    case tba = "tba"
    case unreleased = "unreleased"
    case upcoming = "upcoming"
}

// MARK: - Titles
struct Titles: Codable {
    let en: String?
    let enJp: String
    let enUs, jaJp: String?

    enum CodingKeys: String, CodingKey {
        case en
        case enJp = "en_jp"
        case enUs = "en_us"
        case jaJp = "ja_jp"
    }
}

// MARK: - DatumLinks
struct DatumLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Relationship
struct Relationship: Codable {
    let links: RelationshipLinks
}

// MARK: - RelationshipLinks
struct RelationshipLinks: Codable {
    let linksSelf, related: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case related
    }
}

// MARK: - Links
struct Links: Codable {
    let first, next, last: String
    let prev: String?
}

// MARK: - Meta
struct Meta: Codable {
    let count: Int
}