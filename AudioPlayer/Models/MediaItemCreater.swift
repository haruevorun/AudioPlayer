//
//  MediaItemCreater.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemCreater {
    static func create() -> [MPMediaItemCollection]? {
        return MPMediaQuery.songs().collections
    }
    static func fetchAlbam() -> [MPMediaItemCollection]? {
        return MPMediaQuery.albums().collections
    }
}
