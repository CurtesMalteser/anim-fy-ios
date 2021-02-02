//
//  DetailsSectionProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

// MARK: - Sections
protocol DetailsSectionProtocol {
        var rows: [RowsProtocol] { get }
}

struct PosterSection: DetailsSectionProtocol {
        let rows: [RowsProtocol]
}

struct AttributesSection: DetailsSectionProtocol {
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
