//
//  AttributesProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 1t.01.21.

protocol Attributes: Codable {
    var createdAt: String { get }
    var updatedAt: String { get }
    var slug: String { get }
    var synopsis: String { get }
    var titles: Titles { get }
    var canonicalTitle: String { get }
    var abbreviatedTitles: [String]? { get }
    var averageRating: String? { get }
    var ratingFrequencies: [String: String] { get }
    var userCount: Int { get }
    var favoritesCount: Int { get }
    var startDate: String? { get }
    var endDate: String? { get }
    var popularityRank: Int { get }
    var ratingRank: Int? { get }
    var ageRating: AgeRating? { get }
    var ageRatingGuide: String? { get }
    var status: DataStatus { get }
    var tba: String? { get }
    var posterImage: PosterImage? { get }
    var coverImage: CoverImage? { get }
}

extension Attributes {

    func optionalAttrToString<T: Attributes>(val: (T) -> String) -> String {
        val(self as! T)
    }

    func optionalAgeRatingToString() -> String {
        ageRating?.rawValue ?? "N/A"
    }

    func optionalAgeRatingGuideToString() -> String {
        ageRatingGuide ?? "N/A"
    }

    func optionalRatingRankToString() -> String {
        ratingRank != nil ? String(ratingRank!) : "N/A"
    }

}