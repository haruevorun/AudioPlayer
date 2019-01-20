//
//  AudioPlayerSectionController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import MediaPlayer

class AudioPlayerSectionController: ListSectionController {
    private var mediaCollection: MPMediaItemCollection?
    private var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    
    override func numberOfItems() -> Int {
        return 3
    }
    override func sizeForItem(at index: Int) -> CGSize {
        guard index != 0 else {
            return CGSize(width: collectionContext!.containerSize.width, height: collectionContext!.containerSize.width + 20)
        }
        return CGSize(width: collectionContext!.containerSize.width, height: 200)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard index != 0 else {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "AudioArtworkCollectionViewCell", bundle: nil, for: self, at: index) as? AudioArtworkCollectionViewCell else {
                fatalError()
            }
            cell.image = player.nowPlayingItem?.artwork?.image(at: CGSize(width: 300, height: 300))
            return cell
        }
        guard index != 1 else {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "AudioSeekBarCollectionViewCell", bundle: nil, for: self, at: index) as? AudioSeekBarCollectionViewCell else {
                fatalError()
            }
            return cell
        }
        guard index != 2 else {
            guard let cell = collectionContext?.dequeueReusableCell(withNibName: "AudioControllerCollectionViewCell", bundle: nil, for: self, at: index) as? AudioControllerCollectionViewCell else {
                fatalError()
            }
            return cell
        }
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "AudioDescriptionCollectionViewCell", bundle: nil, for: self, at: index) as? AudioDescriptionCollectionViewCell else {
            fatalError()
        }
        return cell
    }
    override func didUpdate(to object: Any) {
        self.mediaCollection = object as? MPMediaItemCollection
    }
}
