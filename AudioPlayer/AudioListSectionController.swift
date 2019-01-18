//
//  AudioListSectionController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import IGListKit

class AudioListSectionController: ListSectionController {
    private var item: AudioItem?
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "AudioListCollectionViewCell", bundle: nil, for: self, at: index) as? AudioListCollectionViewCell else {
            fatalError()
        }
        cell.item = self.item
        return cell
    }
    override func didUpdate(to object: Any) {
        item = object as? AudioItem
    }
    override func didSelectItem(at index: Int) {
        guard let cell = cellForItem(at: index) as? AudioListCollectionViewCell, let viewController = self.viewController as? AudioListViewController else {
            return
        }
        guard let item = cell.item else {
            return
        }
        viewController.presentAudioView(item: item.item)
    }
}
