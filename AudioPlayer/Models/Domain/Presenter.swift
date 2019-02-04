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
    func finishedFetchQuery(query: MPMediaQuery)
}

class Presenter {
    private let useCase: UseCaseProtocol
    weak var output: PresenterOutput?
    init(useCase: UseCaseProtocol) {
        self.useCase = useCase
    }
    func startFetch() {
        self.useCase.fetch { [weak self] (query) in
            self?.output?.finishedFetchQuery(query: query)
        }
    }
}
