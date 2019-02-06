//
//  ArtistGateway.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol PresenterOutput: class {
    func finishedFetchQuery(query: MPMediaQuery?)
}

class MediaQueryFetcher {
    weak var output: PresenterOutput?
    private var useCase: MediaItemsUseCaseProtocol?
    func fetch(fetchGroup: MPMediaGrouping, isAppleMusic: Bool) {
        self.fetch(with: nil, fetchGroup: fetchGroup, isAppleMusic: isAppleMusic)
    }
    func fetch(with keyword: String?, fetchGroup: MPMediaGrouping, isAppleMusic: Bool) {
        self.useCase = MediaItemsUseCase(group: fetchGroup, isAppleMusic: isAppleMusic)
        self.useCase?.fetch(keyword: keyword ?? "", complition: { [weak self] (query) in
            self?.output?.finishedFetchQuery(query: query)
        })
    }
    // TODO: AppleMusicのオンラインアイテム用のフェッチメソッド
}
