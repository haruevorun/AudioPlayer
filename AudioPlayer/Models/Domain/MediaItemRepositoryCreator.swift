//
//  MediaItemsRepositoryCreator.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemRepositoryCreator {
    static func create(group: MPMediaGrouping) -> MediaItemsRepository? {
        switch group {
        case .album:
            return AlbamRepository.shared
        case .artist:
            return ArtistRepository.shared
        default:
            return nil
        }
    }
}
