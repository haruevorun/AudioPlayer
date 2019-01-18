//
//  AudioListDataSource.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import IGListKit
import MediaPlayer

protocol AudioListDataSourceDelegate {
    func updateItem()
}

class AudioListDataSource: NSObject, ListAdapterDataSource {
    private var items: [AudioItem] = []
    var delegate: AudioListDataSourceDelegate?
    func request() {
        MPMediaLibrary.requestAuthorization { (state) in
            switch state {
            case .authorized:
                self.fetchItem()
            default:
                return
            }
        }
    }
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return AudioListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    private func fetchItem() {
        guard let collections = MediaItemCreater.create() else {
            return
        }
        DispatchQueue.global().async {
            for collection in collections {
                self.items.append(contentsOf: collection.items.map { AudioItem(media: $0) } )
            }
            DispatchQueue.main.async {
                self.delegate?.updateItem()
            }
        }
    }
}
