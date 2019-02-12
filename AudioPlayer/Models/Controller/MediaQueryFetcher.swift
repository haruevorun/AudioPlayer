//
//  ArtistGateway.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol MediaItemsFetchResult: class {
    func finishedFetchQuery(query: MPMediaQuery?)
}

class MediaQueryFetcher {
    weak var output: MediaItemsFetchResult?
    private var useCase: MediaItemsUseCaseProtocol?
    func fetch(cases: MediaItemsUseCase.QueryCase,with filter:Set<MPMediaPropertyPredicate>, isAppleMusic: Bool) {
        self.useCase = MediaItemsUseCase(with: cases, isAppleMusic)
        self.useCase?.fetch(filter: filter, completion: { (query) in
            self.output?.finishedFetchQuery(query: query)
        })
    }
    // TODO: AppleMusicのオンラインアイテム用のフェッチメソッド
}
