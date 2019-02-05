//
//  MediaQueryConfigure.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/05.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaQueryConfigure {
    static func createUseCase(group: MPMediaGrouping) -> UseCaseProtocol? {
        switch group {
        case .album:
            return MediaItemUseCase(repository: AlbamRepository.shared)
        case .artist:
            return MediaItemUseCase(repository: ArtistRepository.shared)
        default:
            return nil
        }
    }
}
