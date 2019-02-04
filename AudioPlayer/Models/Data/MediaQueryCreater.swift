//
//  MediaQueryCreater.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaQueryCreater {
    static func fetchAlbam() -> MPMediaQuery {
        return MPMediaQuery.albums()
    }
    static func fetchArtist() -> MPMediaQuery {
        return MPMediaQuery.artists()
    }
    static func fetchPlaylist() -> MPMediaQuery {
        return MPMediaQuery.playlists()
    }
    static func fetchGenre() -> MPMediaQuery {
        return MPMediaQuery.genres()
    }
    static func fetchSongs() -> MPMediaQuery {
        return MPMediaQuery.songs()
    }
    static func fetchAlbam(albamSerchKey: String) -> MPMediaQuery {
        let query = MPMediaQuery.albums()
        let predicate = MPMediaPropertyPredicate(value: albamSerchKey, forProperty: MPMediaItemPropertyTitle)
        query.addFilterPredicate(predicate)
        return query
    }
    static func fetchAlbam(artistSerchKey: String) -> MPMediaQuery {
        let query = MPMediaQuery.albums()
        let predicate = MPMediaPropertyPredicate(value: artistSerchKey, forProperty: MPMediaItemPropertyArtist)
        query.addFilterPredicate(predicate)
        return query
    }
}
