//
//  UIImage+ImagePlaceHolder.swift
//  AnimFy, firstly used on Virtual Tourist project.
//
//  Created by António Bastião on 29.12.20.
//

import UIKit

extension UIImage {
    class func imagePlaceholder() -> UIImage? {
        self.init(named: "ImagePlaceholder")
    }

    class func imageUserCount() -> UIImage? {
        self.init(named: "UserCount")
    }

    class func imageFavoritesCount() -> UIImage? {
        self.init(named: "FavoritesCount")
    }

    class func imageStatus() -> UIImage? {
        self.init(named: "StatusIcon")
    }

    class func imageInfo() -> UIImage? {
        self.init(named: "InfoIcon")
    }

    class func imageManga() -> UIImage? {
        self.init(named: "BookClosed")
    }

    class func imageChapters() -> UIImage? {
        self.init(named: "BookOpen")
    }

    class func imageVolumes() -> UIImage? {
        self.init(named: "MultipleBooks")
    }

    class func imageAgeRating() -> UIImage? {
        self.init(named: "CalendarExclamation")
    }

    class func imagePopularityRank() -> UIImage? {
        self.init(named: "UsersThree")
    }

    class func imageRatingRank() -> UIImage? {
        self.init(named: "ArrowUpDown")
    }

    class func imageAnime() -> UIImage? {
        self.init(named: "TicketIcon")
    }

    class func imageAnimeEpisodes() -> UIImage? {
        self.init(named: "SquareStack")
    }

    class func imageShowMore() -> UIImage? {
        self.init(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate)
    }

    class func imageNotFavorite() -> UIImage? {
        self.init(systemName: "suit.heart")?.withRenderingMode(.alwaysTemplate)
    }

    class func imageFavorite() -> UIImage? {
        self.init(systemName: "suit.heart.fill")?.withRenderingMode(.alwaysTemplate)
    }

    class func imagePlus() -> UIImage? {
        self.init(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
    }

    class func imageCheck() -> UIImage? {
        self.init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
    }

}