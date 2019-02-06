//
//  AlbamDataStore.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class AlbamDataStore: MediaItemsDataStore {
    
    func fetchItem(keyword: String) -> MPMediaQuery {
        let query = MPMediaQuery.albums()
        let predicate = MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.contains)
        query.addFilterPredicate(predicate)
        return query
    }
}
