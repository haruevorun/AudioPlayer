//
//  AlbamDataStore.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class AlbamDataStore: ItemDataStore {
    func fetchAllItem() -> MPMediaQuery {
        return MPMediaQuery.albums()
    }
    
    func serchItem(keyword: String) -> MPMediaQuery {
        let query = MPMediaQuery.albums()
        let predicate = MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyAlbumTitle)
        query.addFilterPredicate(predicate)
        return query
    }
}
