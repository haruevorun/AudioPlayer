//
//  AlbamRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class AlbamRepository: ItemRepository {
    
    static let shared: ItemRepository = AlbamRepository()
    
    let dataStore: ItemDataStore?
    
    init (){
        self.dataStore = ItemDataStoreFactory.createLibraryDataStore(group: .album)
    }
    
    func fetch(complition: @escaping (MPMediaQuery?) -> Void) {
        let datastore = AlbamDataStore()
        complition(datastore.fetchAllItem())
    }
    
    func fetch(keyword: String, complition: @escaping (MPMediaQuery?) -> Void) {
        let datastore = AlbamDataStore()
        complition(datastore.searchItem(keyword: keyword))
    }
}
