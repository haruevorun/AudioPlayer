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
    enum QueryCase {
        case album
        case artist
        case audiobooks
        case composers
        case genres
        case playlists
        case podcasts
        case songs
    }
    private var cases: QueryCase
    let repository: MediaItemsRepository?
    init(with cases: QueryCase,_ isAppleMusic: Bool) {
        self.cases = cases
        switch isAppleMusic {
        case true:
            self.repository = nil
        case false:
            self.repository = MediaItemsRepositoryImpl()
        }
    }
    func fetch(filter: Set<MPMediaPropertyPredicate>, completion: @escaping ((MPMediaQuery?) -> Void)) {
        self.repository?.fetch(queryCase: self.cases, filter: filter) { (query) in
            completion(query)
        }
    }
}
