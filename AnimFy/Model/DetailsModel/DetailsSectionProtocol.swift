//
//  DetailsSectionProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

// MARK: - Sections
protocol DetailsSectionProtocol {
        var label: String { get }
        var rows: [RowsProtocol] { get }
}

struct PosterSection: DetailsSectionProtocol {
        var label: String
        let rows: [RowsProtocol]
}

struct AttributesSection: DetailsSectionProtocol {
        var label: String
        let rows: [RowsProtocol]
}

// MARK: - Rows
protocol RowsProtocol {}

struct RatingRow: RowsProtocol {
        let userCount: Int
        let favoritesCount: Int
        let popularityRank: Int
        let ratingRank: Int?
        let ageRating: AgeRating?
}
