//
//  ArtistRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
class ArtistRepository: MediaItemRepository {
    let dataStore: ItemDataStore?
    
    static let shared: MediaItemRepository = ArtistRepository()
    init() {
        self.dataStore = ItemDataStoreFactory.createLibraryDataStore(group: .artist)
    }
    
    func fetch(complition: @escaping (MPMediaQuery?) -> Void) {
        let dataStore = ArtistDataStore()
        complition(dataStore.fetchAllItem())
    }
    func fetch(keyword: String, complition: @escaping (MPMediaQuery?) -> Void) {
        let dataStore = ArtistDataStore()
        complition(dataStore.searchItem(keyword: keyword))
    }
}

