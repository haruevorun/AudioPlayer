//
//  ArtistRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
class LocalMediaRepository: MediaItemsRepository {
    let dataStore: MediaItemsDataStore?
    
    init(group: MPMediaGrouping) {
        self.dataStore = MediaItemsDataStoreCreator.createLibraryDataStore(group: group)
    }
    
    func fetch(keyword: String, completion: @escaping (MPMediaQuery?) -> Void) {
        completion(dataStore?.fetchItem(keyword: keyword))
    }
}

