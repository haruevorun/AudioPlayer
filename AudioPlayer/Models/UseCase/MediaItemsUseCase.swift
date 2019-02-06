//
//  MediaItemsUseCase.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemsUseCase: MediaItemsUseCaseProtocol {
    
    let repository: MediaItemsRepository?
    init(group: MPMediaGrouping, isAppleMusic: Bool) {
        switch isAppleMusic {
        case true:
            self.repository = MediaItemsRepositoryCreator.createAppleMusicRepository(group: group)
        case false:
            self.repository = MediaItemsRepositoryCreator.create(group: group)
        }
    }
    func fetch(keyword: String, complition: @escaping ((MPMediaQuery?) -> Void)) {
        self.repository?.fetch(keyword: keyword) { (query) in
            complition(query)
        }
    }
}
