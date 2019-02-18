//
//  AudioQueueController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/18.
//  Copyright © 2019 teranyan. All rights reserved.
//
/*
 query: queryの中を直接操作はできない。setQueueのみ更新可
 currentQueue: shuffle操作、配列並び替え可。
 */

import Foundation
import UIKit
import MediaPlayer

protocol MediaPlayerQueueControllerInputProtocol {
    var isShuffled: Bool { get set }
    func setQueue(query: MPMediaQuery)
    func addFilter(filter: MPMediaPropertyPredicate)
    func removeFilter(filter: MPMediaPropertyPredicate)
}
protocol MediaPlayerQueueControllerOutputProtocol {
    func setPlayItem() -> MPMediaItem?
    func setNextItem() -> MPMediaItem?
    func setPreviousItem() -> MPMediaItem?
    func setSelectItem(index: Int?) -> MPMediaItem?
}

class AudioQueueController: MediaPlayerOutputQueueProtocol {
    static let shared = AudioQueueController()
    
    private var query: MPMediaQuery? = nil
    private var playingItem: MPMediaItem? = nil
    private var currentQueue: [MPMediaItem] = []
    private var index: Int? = nil
    
    private var shuffled: Bool = false {
        didSet {
            updateQueue()
        }
    }
    
    var isShuffled: Bool {
        get {
            return self.shuffled
        }
        set(value) {
            self.shuffled = value
        }
    }
    
    var nowPlayingItem: MPMediaItem? {
        return self.playingItem
    }
    
    var indexOfNowPlayingItem: Int? {
        return self.index
    }
    
    var queue: [MPMediaItem] {
        return self.currentQueue
    }
    
    var queueCount: Int {
        return self.currentQueue.count
    }
    private func nextIndex() -> Int? {
        guard var index: Int = self.index else {
            return nil
        }
        index += 1
        guard index >= self.queueCount else {
            self.index = index
            return index
        }
        self.index = 0
        return 0
    }
    private func previousIndex() -> Int? {
        guard var index: Int = self.index else {
            return nil
        }
        index -= 1
        guard index > 0 else {
            return 0
        }
        self.index = index
        return index
    }
    
    private func updateQuery(query: MPMediaQuery) {
        self.query = query
        self.index = 0
        self.updateQueue()
    }
    
    private func updateQueue() {
        if shuffled {
            self.currentQueue = shuffleQueue(items: self.query?.items ?? [])
        } else {
            self.currentQueue = self.query?.items ?? []
        }
    }
    private func shuffleQueue(items: [MPMediaItem]) -> [MPMediaItem] {
        var swapedItems = items
        let n = items.count
        for i in 0 ..< n {
            let r = Int(arc4random_uniform(UInt32(n - i))) + i
            swapedItems.swapAt(i, r)
        }
        return swapedItems
    }
}
extension AudioQueueController: MediaPlayerQueueControllerInputProtocol {
    
    func setQueue(query: MPMediaQuery) {
        updateQuery(query: query)
    }
    
    func addFilter(filter: MPMediaPropertyPredicate) {
        self.query?.addFilterPredicate(filter)
        updateQueue()
    }
    
    func removeFilter(filter: MPMediaPropertyPredicate) {
        self.query?.removeFilterPredicate(filter)
        updateQueue()
    }
}
extension AudioQueueController: MediaPlayerQueueControllerOutputProtocol {
    func setPlayItem() -> MPMediaItem? {
        guard self.index == nil else {
            return self.currentQueue[index!]
        }
        return self.currentQueue[0]
    }
    
    func setNextItem() -> MPMediaItem? {
        let index: Int? = nextIndex()
        guard index != nil else {
            return nil
        }
        return self.currentQueue[index!]
    }
    
    func setPreviousItem() -> MPMediaItem? {
        let index: Int? = previousIndex()
        guard index != nil else {
            return nil
        }
        return self.currentQueue[index!]
    }
    
    func setSelectItem(index: Int?) -> MPMediaItem? {
        var index: Int = index ?? 0
        defer {
            self.index = index
        }
        if 0 ..< self.queueCount ~= index {
            return self.currentQueue[index]
        } else {
            index = 0
            return self.currentQueue[index]
        }
    }
}
