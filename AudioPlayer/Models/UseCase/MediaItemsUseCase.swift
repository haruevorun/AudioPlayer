//
//  MediaItemsUseCase.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaItemUseCase: UseCaseProtocol {
    
    let repository: ItemRepository
    init(repository: ItemRepository) {
        self.repository = repository
    }
    func fetch(complition: @escaping ((MPMediaQuery?) -> Void)) {
        self.repository.fetch { (query) in
            //ここで別モデルに変換するhttp://hachinobu.hateblo.jp/entry/2016/10/13/222316
            complition(query)
        }
    }
    func serch(keyword: String, complition: @escaping ((MPMediaQuery?) -> Void)) {
        self.repository.fetch(keyword: keyword) { (query) in
            complition(query)
        }
    }
    
}
