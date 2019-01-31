//
//  ShuffleMPMediaItemCollection.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/30.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

extension MPMediaItemCollection {
    internal static func shuffledCollection(items: [MPMediaItem]) -> MPMediaItemCollection {
        var swapedItems = items
        let n = items.count
        for i in 0 ..< n {
            let r = Int(arc4random_uniform(UInt32(n - i))) + i
            swapedItems.swapAt(i, r)
        }
        return MPMediaItemCollection(items: swapedItems)
    }
}
