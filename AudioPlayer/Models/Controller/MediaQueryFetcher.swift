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
    private var useCase: UseCaseProtocol?
    func fetch(fechGroup: MPMediaGrouping) {
        self.useCase = MediaItemsUseCaseCreator.createUseCase(group: fechGroup)
        self.useCase?.fetch { [weak self] (query) in
            self?.output?.finishedFetchQuery(query: query)
        }
    }
    func fetch(with keyword: String?, fetchGroup: MPMediaGrouping) {
        self.useCase = MediaItemsUseCaseCreator.createUseCase(group: fetchGroup)
        self.useCase?.serch(keyword: keyword ?? "", complition: { [weak self] (query) in
            self?.output?.finishedFetchQuery(query: query)
        })
    }
    // TODO: AppleMusicのオンラインアイテム用のフェッチメソッド
}
