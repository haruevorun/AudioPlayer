//
//  AudioPlaybackController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol ProvisionalInputProtocol {
    func inputQueue(query: MPMediaQuery)
}

class AudioPlayerController: ProvisionalInputProtocol {
    
    static let sharedPlayerController = AudioPlayerController()
    
    private let player: MPMusicPlayerApplicationController
    private var output: MediaPlayerQueueControllerOutputProtocol = AudioQueueController.sharedQueueController
    private var input: MediaPlayerQueueControllerInputProtocol = AudioQueueController.sharedQueueController
    
    init() {
        self.player = MPMusicPlayerApplicationController.applicationQueuePlayer
        self.setupPlayer()
    }
    
    private func setupPlayer() {
        self.player.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePlayingItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        self.player.endGeneratingPlaybackNotifications()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) {timer in
            if self.player.repeatMode != .none || self.player.shuffleMode != .off {
                DebugUtil.log("not shuffle mode")
                self.player.repeatMode = .none
                self.player.shuffleMode = .off
            } else {
                print("set shuffle mode")
                timer.invalidate()
            }
        }
    }
    
    private func prepare(item: MPMediaItem?) {
        guard let item = item, self.player.nowPlayingItem != item else {
            return
        }
        let collection = MPMediaItemCollection(items: [item])
        self.player.setQueue(with: collection)
        self.player.prepareToPlay()
    }
    
    func inputQueue(query: MPMediaQuery) {
        self.input.queue(query: query)
    }
}

extension AudioPlayerController: MediaPlayerInputQueueProtocol {
    
    func setQueue(query: MPMediaQuery, playingItem: MPMediaItem?, isPlay: Bool) {
        self.input.queue(query: query)
        self.player.nowPlayingItem = playingItem
        if isPlay {
            self.play()
        }
    }
    
    func updateQueue(playingItem: MPMediaItem?, isPlay: Bool) {
        self.player.nowPlayingItem = playingItem
        if isPlay {
            self.player.play()
        }
    }
    
    func updateQueue(index: Int, isPlay: Bool) {
        if isPlay {
            self.player.play()
        }
    }
}

extension AudioPlayerController: MediaPlayerControlProtocol {
    
    func play() {
        self.prepare(item: self.output.setPlayItem())
        self.player.play()
    }
    
    func pause() {
        self.player.pause()
    }
    
    func skipToNext() {
        self.prepare(item: self.output.setNextItem())
        self.player.play()
        self.player.repeatMode = .none
    }
    
    func skipToPrevious() {
        self.prepare(item: self.output.setPreviousItem())
        self.player.play()
    }
    
    func skipToItem(index: Int, isPlay: Bool) {
        self.prepare(item: self.output.setSelectItem(index: index))
        if isPlay {
            self.player.play()
        }
    }
    
    func seek(time: TimeInterval) {
        self.player.currentPlaybackTime = time
    }
}

extension AudioPlayerController: MediaPlayerStateProtocol {
    
    var isPlay: Bool {
        return self.player.playbackState == .playing
    }
    var currentTime: TimeInterval {
        return self.player.currentPlaybackTime
    }
    var maximumMediaItemDuration: TimeInterval {
        return self.player.nowPlayingItem?.playbackDuration ?? TimeInterval(0)
    }
}

extension AudioPlayerController: MediaPlayerArtworkProtocol {
    
    var image: UIImage? {
        return self.player.nowPlayingItem?.artwork?.image(at: MPMediaItem.albumJacketSize)
    }
    var title: String {
        return self.player.nowPlayingItem?.title ?? ""
    }
    var artist: String {
        return self.player.nowPlayingItem?.artist ?? ""
    }
}

extension AudioPlayerController {
    
    @objc private func didChangePlayingItem() {
        defer {
            NotificationCenter.default.post(name: NSNotification.Name.AudioPlayerDidChangeItem, object: nil)
        }
        guard self.player.nowPlayingItem != nil else {
            self.player.skipToNextItem()
            return
        }
    }
}

extension NSNotification.Name {
    
    static let AudioPlayerDidChangeItem: NSNotification.Name = NSNotification.Name("MediaPlayerDidChangeItem")
}
