//
//  AudioItem.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import IGListKit
import MediaPlayer

class AudioItem {
    let id: MPMediaEntityPersistentID
    let url: URL?
    let title: String
    let artist: String
    init(media: MPMediaItem) {
        self.id = media.persistentID
        self.url = media.assetURL
        self.title = media.title ?? "Unknown"
        self.artist = media.artist ?? "Unknown"
    }
}
extension AudioItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else {
            return true
        }
        guard let object = object as? AudioItem else {
            return false
        }
        return self.url == object.url && self.title == object.title && self.artist == object.artist
    }
}
