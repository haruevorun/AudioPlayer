//
//  AudioPlayer.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/28.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class MusicPlayer: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var timer: Timer = Timer()
    let player: MPMusicPlayerApplicationController = MPMusicPlayerApplicationController.applicationQueuePlayer
    private var keyObservers: [NSKeyValueObservation] = []
    
    let artworkCellIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    let controllerCellIndexPath: IndexPath = IndexPath(item: 1, section: 0)
    let artworkCellHeight: CGFloat = 500
    let controllerCellHeight: CGFloat = 250
    private var collection: MPMediaItemCollection?
    
    private var queue: [MPMediaItem] = []
    private var count: Int = 10
    
    private var canSkipToPrevious: Bool {
        guard self.player.nowPlayingItem != nil else {
            return false
        }
        return self.player.currentPlaybackTime <= 2.0 && self.player.indexOfNowPlayingItem > 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("player deinit")
        self.player.endGeneratingPlaybackNotifications()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AudioControllerCell", bundle: nil), forCellReuseIdentifier: "ControllCell")
        self.tableView.register(UINib(nibName: "AudioArtworkCell", bundle: nil), forCellReuseIdentifier: "ArtworkCell")
        self.tableView.register(UINib(nibName: "AudioQueueCell", bundle: nil), forCellReuseIdentifier: "QueueCell")
        self.tableView.register(UINib(nibName: "AudioQueueSectionHeader", bundle: nil), forCellReuseIdentifier: "QueueHeader")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSeekBar(timer:)), userInfo: nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(changePlayItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePlaybackState), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        self.player.beginGeneratingPlaybackNotifications()
    }
    @objc private func changePlaybackState() {
        switch self.player.playbackState {
        case .playing:
            updatePlaybackIcon(isPlay: true)
        case .paused:
            updatePlaybackIcon(isPlay: false)
        default:
            return
        }
    }
    @objc private func changePlayItem() {
        guard let artwork = artworkView(), let controller = controlView(), let playItem = self.player.nowPlayingItem else {
            return
        }
        self.tableView.selectRow(at: IndexPath(item: self.player.indexOfNowPlayingItem, section: 1), animated: true, scrollPosition: .none)
        controller.updateMaxSeekValue(value: Float(playItem.playbackDuration))
        let image = playItem.artwork?.image(at: MPMediaItem.albamJacketSize)
        artwork.setupItem(playItem.title, playItem.artist, image)
    }
    private func insert(item: MPMediaItem, after: Int) {
        self.player.perform(queueTransaction: { (mutableQueue) in
            let predicate = MPMediaPropertyPredicate(value: item.persistentID,
                                                     forProperty: MPMediaItemPropertyPersistentID)
            let query = MPMediaQuery(filterPredicates: [predicate])
            let descriptor = MPMusicPlayerMediaItemQueueDescriptor(query: query)
            mutableQueue.insert(descriptor, after: mutableQueue.items.last!)
        }) { (queue, error) in
            print(queue.items.map {$0.title})
        }
    }
}
extension MusicPlayer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return false
        default:
            return true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.player.nowPlayingItem != self.queue[indexPath.item] else {
            return
        }
        self.player.pause()
        self.player.currentPlaybackTime = 0
        self.player.nowPlayingItem = queue[indexPath.item]
        print(self.queue[indexPath.item].title as Any)
        self.player.play()
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
        case 0:
            return nil
        default:
            return indexPath
        }
    }
    func tableView(_ tableView:UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath.section != sourceIndexPath.section) {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
}
extension MusicPlayer: UITableViewDataSource {
    
    func setup(collection: MPMediaItemCollection, isShuffle: Bool) {
        self.collection = collection
        guard isShuffle else {
            self.setQueue(collection: collection)
            return
        }
        self.shuffle(collection: collection)
    }
    
    private func shuffle(collection: MPMediaItemCollection) {
        self.collection = MPMediaItemCollection.shuffledCollection(items: collection.items)
        setQueue(collection: self.collection!)
    }
    
    private func setQueue(collection: MPMediaItemCollection) {
        self.queue = collection.items
        self.player.stop()
        self.player.setQueue(with: collection)
        self.player.prepareToPlay()
        self.player.shuffleMode = .off
        self.player.nowPlayingItem = self.queue[0]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return queue.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createControllÇell(tableview: tableView, item: indexPath.item)
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QueueCell", for: indexPath) as? AudioQueueCell else {
                fatalError()
            }
            cell.title = queue[indexPath.item].title
            cell.artworkImage = queue[indexPath.item].artwork?.image(at: MPMediaItem.albamJacketThumbnailSize)
            cell.artist = queue[indexPath.item].artist
            return cell
        }
    }
    private func createControllÇell(tableview: UITableView, item: Int) -> UITableViewCell {
        switch item {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ArtworkCell", for: artworkCellIndexPath) as? AudioArtworkCell else {
                fatalError()
            }
            let item = self.player.nowPlayingItem
            cell.setupItem(item?.title, item?.artist, item?.artwork?.image(at: MPMediaItem.albamJacketSize))
            return cell
        case 1:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ControllCell", for: controllerCellIndexPath) as? AudioControllerCell else {
                fatalError()
            }
            let item = self.player.nowPlayingItem?.playbackDuration
            cell.updateMaxSeekValue(value: Float(item!))
            cell.delegate = self
            return cell
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                return self.artworkCellHeight
            } else {
                return self.controllerCellHeight
            }
        default:
            return 70
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: "QueueHeader")
        }
    }
    private func controlView() -> AudioControllerCell? {
        guard let cell = tableView?.cellForRow(at: self.controllerCellIndexPath) as? AudioControllerCell else {
            return nil
        }
        return cell
    }
    private func artworkView() -> AudioArtworkCell? {
        guard let cell = tableView?.cellForRow(at: self.artworkCellIndexPath) as? AudioArtworkCell else {
            return nil
        }
        return cell
    }
    
    @objc func updateSeekBar(timer: Timer) {
        if let controlView = controlView() {
            controlView.currentPlayBackValue = Float(self.player.currentPlaybackTime)
        }
    }
    func updatePlaybackIcon(isPlay: Bool) {
        if let controlView = controlView() {
            controlView.isPlay = isPlay
        }
    }
}
extension MusicPlayer: AudioControlProtocol {
    
    func playback(isPlay: Bool) {
        if isPlay {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func skip() {
        player.skipToNextItem()
    }
    
    func backToBeginning() {
        guard canSkipToPrevious else {
            player.skipToBeginning()
            return
        }
        player.skipToPreviousItem()
    }
    
    func seek(value: Float) {
        self.player.currentPlaybackTime = TimeInterval(value)
    }
}
