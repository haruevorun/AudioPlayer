//
//  ItemDataStoreFactory.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemsDataStoreCreator {
    static func createLibraryDataStore(group: MPMediaGrouping) -> MediaItemsDataStore? {
        switch group {
        case .album:
            return AlbamDataStore()
        case .artist:
            return ArtistDataStore()
        case .genre:
            return GenreDataStore()
        case .playlist:
            return PlayListDataStore()
        default:
            return nil
        }
    }
}
