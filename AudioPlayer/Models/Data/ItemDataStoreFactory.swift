//
//  ItemDataStoreFactory.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

class ItemDataStoreFactory {
    static func fetchArtist() -> ItemDataStore {
        return ArtistDataStore()
    }
    static func fetchAlbam() -> ItemDataStore {
        return AlbamDataStore()
    }
}
