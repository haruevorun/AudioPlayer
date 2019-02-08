//
//  GenreDataStore.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/07.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class GenreDataStore: MediaItemsDataStore {
    func fetchItem(keyword: String) -> MPMediaQuery {
        let query = MPMediaQuery.genres()
        let filter = MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyGenre, comparisonType: .contains)
        query.addFilterPredicate(filter)
        return query
    }
}
