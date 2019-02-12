//
//  ItemDataStoreFactory.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemsLocalDataStoreImpl: MediaItemsLocalDataStore {
    func fetchItem(queryCase: MediaItemsUseCase.QueryCase, filter: Set<MPMediaPropertyPredicate>) -> MPMediaQuery {
        let query = createQuery(queryCase: queryCase)
        for predicate in filter {
            query.addFilterPredicate(predicate)
        }
        return query
    }
    private func createQuery(queryCase: MediaItemsUseCase.QueryCase) -> MPMediaQuery {
        switch queryCase {
        case .album:
            return MPMediaQuery.albums()
        case .artist:
            return MPMediaQuery.artists()
        case .audiobooks:
            return MPMediaQuery.audiobooks()
        case .composers:
            return MPMediaQuery.composers()
        case .genres:
            return MPMediaQuery.genres()
        case .playlists:
            return MPMediaQuery.playlists()
        case .podcasts:
            return MPMediaQuery.podcasts()
        case .songs:
            return MPMediaQuery.songs()
        }
    }
    
    func fetchItem(filter: Set<MPMediaPropertyPredicate>) -> MPMediaQuery {
        return MPMediaQuery(filterPredicates: filter)
    }
}
