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
    let controllerCellHeight: CGFloat = 150
    
    private var queueStack: [MPMediaItem] = []
    private var count: Int = 10
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("player deinit")
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
        self.tableView.isEditing = true
        self.tableView.allowsSelectionDuringEditing = true
        self.player.shuffleMode = MPMusicShuffleMode.off
        self.player.repeatMode = MPMusicRepeatMode.none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player.play()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSeekBar(timer:)), userInfo: nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        timer.invalidate()
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(changePlayItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePlaybackState), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
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
        guard let artwork = artworkView(), let controller = controlView() else {
            return
        }
        let nowPlayingItemIndex = self.player.indexOfNowPlayingItem
        let playItem = self.queueStack[nowPlayingItemIndex]
        controller.updateMaximumValue(value: Float(playItem.playbackDuration))
        artwork.artworkImage = playItem.artwork?.image(at: MPMediaItem.albamJacketSize)
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
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
        case 0:
            return nil
        default:
            return indexPath
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                return tableView.frame.width
            } else {
                return self.controllerCellHeight
            }
        default:
            return 70
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return false
        default:
            return true
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 移動後の処理tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
    func tableView(_ tableView:UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath.section != sourceIndexPath.section) {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
extension MusicPlayer: UITableViewDataSource {
    
    func setQueue(collection: MPMediaItemCollection) {
        self.player.stop()
        self.queueStack = collection.items
        self.player.setQueue(with: collection)
        self.player.nowPlayingItem = collection.items.first!
        self.queueStack = collection.items
    }
    
    func insertQueue(collection: MPMediaItemCollection) {
        self.player.perform(queueTransaction: { (mutableQueue) in
            let descriptor: MPMusicPlayerQueueDescriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: collection)
            mutableQueue.insert(descriptor, after: mutableQueue.items.last)
        }) { (queue, error) in
            print(queue)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return queueStack.count
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
            cell.title = queueStack[indexPath.item].title
            return cell
        }
    }
    private func createControllÇell(tableview: UITableView, item: Int) -> UITableViewCell {
        switch item {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ArtworkCell", for: artworkCellIndexPath) as? AudioArtworkCell else {
                fatalError()
            }
            guard let artImage = player.nowPlayingItem?.artwork?.image(at: MPMediaItem.albamJacketSize) else {
                return cell
            }
            cell.artworkImage = artImage
            return cell
        case 1:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ControllCell", for: controllerCellIndexPath) as? AudioControllerCell else {
                fatalError()
            }
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
    func updateMusicjacket(image: UIImage) {
        if let artworkView = artworkView() {
            artworkView.artworkImage = image
        }
    }
}
extension MusicPlayer: AudioControlProtocol {
    
    func playback(isPlay: Bool) {
        if isPlay {
            player.pause()
        } else {
            player.prepareToPlay()
            player.play()
        }
    }
    
    func skip() {
        player.skipToNextItem()
    }
    
    func backToBeginning() {
        player.skipToBeginning()
    }
    
    func seek(value: Float) {
        self.player.currentPlaybackTime = TimeInterval(value)
    }
}
