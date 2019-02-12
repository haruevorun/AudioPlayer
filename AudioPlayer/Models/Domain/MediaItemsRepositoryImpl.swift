//
//  ArtistRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
class MediaItemsRepositoryImpl: MediaItemsRepository {
    func fetch(queryCase: MediaItemsUseCase.QueryCase, filter: Set<MPMediaPropertyPredicate>, completion: @escaping (MPMediaQuery?) -> Void) {
        completion(dataStore?.fetchItem(queryCase: queryCase, filter: filter))
    }
    
    
    let dataStore: MediaItemsLocalDataStore?
    
    init() {
        self.dataStore = MediaItemsLocalDataStoreImpl()
    }
}

