//
//  MediaItemsRepositoryCreator.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemsRepositoryCreator {
    static func createAppleMusicRepository(group: MPMediaGrouping) -> MediaItemsRepository? {
        return nil
    }
    static func create(group: MPMediaGrouping) -> MediaItemsRepository? {
        return LocalMediaRepository(group: group)
    }
}
