//
//  ItemDataStoreFactory.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class ItemDataStoreCreator {
    static func createLibraryDataStore(group: MPMediaGrouping) -> ItemDataStore? {
        switch group {
        case .album:
            return AlbamDataStore()
        case .artist:
            return ArtistDataStore()
        default:
            return nil
        }
    }
}
