//
//  ArtistRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
class ArtistRepository: ItemRepository {
    static let shared: ItemRepository = ArtistRepository()
    func fetch(complition: @escaping (MPMediaQuery) -> Void) {
        let dataStore = ArtistDataStore()
        complition(dataStore.fetchAllItem())
    }
}

