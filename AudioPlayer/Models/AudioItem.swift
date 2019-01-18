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

extension MPMediaItem: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return persistentID as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else {
            return true
        }
        guard let object = object as? MPMediaItem else {
            return false
        }
        return self.playCount == object.playCount && self.skipCount == object.skipCount
    }
}
