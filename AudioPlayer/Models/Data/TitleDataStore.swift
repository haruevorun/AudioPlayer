//
//  TitleDataStore.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class TitleDataStore: MediaItemsDataStore {
    func fetchItem(keyword: String) -> MPMediaQuery {
        let query = MPMediaQuery.songs()
        let filter = MPMediaPropertyPredicate(value: keyword, forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
        query.addFilterPredicate(filter)
        return query
    }
}
