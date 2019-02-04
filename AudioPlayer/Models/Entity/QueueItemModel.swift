//
//  QueueItemModel.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class QueueItemModel {
    var persistentID: MPMediaEntityPersistentID
    var title: String?
    var artist: String?
    var jacketImage: UIImage?
    init(item: MPMediaItem) {
        self.persistentID = item.persistentID
        self.title = item.title
        self.artist = item.artist
        self.jacketImage = item.artwork?.image(at: MPMediaItem.albamJacketThumbnailSize)
    }
}
