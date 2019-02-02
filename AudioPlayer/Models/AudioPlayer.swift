//
//  AudioPlayer.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class AudioPlayer {
    private var player: MPMusicPlayerApplicationController
    private(set) var queue: [MPMediaItem]
    private var nowPlayindex: Int?
    private let collection: MPMediaItemCollection
    private var isSetQueue: Bool {
        return self.player.nowPlayingItem != nil && self.player.currentPlaybackTime != 0
    }
    var currentPlaybackTime: TimeInterval {
        return player.currentPlaybackTime
    }
    var nextIndex: Int {
        guard let nowPlayIndex = self.nowPlayindex else {
            return 0
        }
        if nowPlayIndex + 1 >= self.queue.count {
            return 0
        }
        return nowPlayIndex + 1
    }
    var previousIndex: Int {
        guard let nowPlayIndex = self.nowPlayindex else {
            return 0
        }
        if nowPlayIndex - 1 < 0 {
            return self.queue.count - 1
        }
        return nowPlayIndex  - 1
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.player.endGeneratingPlaybackNotifications()
    }
    init(queue: MPMediaItemCollection) {
        self.player = MPMusicPlayerApplicationController.applicationQueuePlayer
        self.player.shuffleMode = .off
        self.player.repeatMode = .default
        self.collection = queue
        self.queue = queue.items
        self.nowPlayindex = nil
        NotificationCenter.default.addObserver(self, selector: #selector(changedItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: self.player)
        self.player.beginGeneratingPlaybackNotifications()
        self.skipToNext()
    }
    func play() {
        if !self.player.isPreparedToPlay {
            self.player.prepareToPlay()
        }
        self.player.play()
    }
    func pause() {
        self.player.pause()
    }
    func stop() {
        self.player.stop()
    }
    func skipToNext() {
        self.player.currentPlaybackTime = 0
        self.setItem(queueIndex: nextIndex)
    }
    func skipToPrevious() {
        self.player.currentPlaybackTime = 0
        self.setItem(queueIndex: previousIndex)
    }
    func seek(interval: TimeInterval) {
        self.player.currentPlaybackTime = interval
    }
    ///moveした後はqueueが移動するのでviewで再リロードする必要あり
    func moveQueue(fromIndex: Int, toIndex:Int) {
        if self.nowPlayindex == fromIndex {
            self.nowPlayindex = toIndex
        }
        let target = queue[fromIndex]
        queue.remove(at: fromIndex)
        queue.insert(target, at: toIndex)
        self.player.prepareToPlay()
    }
    private func shouldNextItem() {
        self.skipToNext()
        self.play()
    }
    private func setItem(queueIndex: Int) {
        self.player.setQueue(with: MPMediaItemCollection(items: [queue[queueIndex]]))
        self.nowPlayindex = queueIndex
        self.player.prepareToPlay()
    }
    @objc private func stopped() {
        self.skipToNext()
        self.play()
    }
    
    @objc private func changedItem() {
        guard self.player.nowPlayingItem == nil else {
            return
        }
        self.skipToNext()
        self.play()
    }
}
