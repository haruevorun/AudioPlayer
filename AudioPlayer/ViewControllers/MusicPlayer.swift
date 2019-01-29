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
    let player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    private var keyObservers: [NSKeyValueObservation] = []
    
    let artworkCellIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    let controllerCellIndexPath: IndexPath = IndexPath(item: 1, section: 0)
    let controllerCellHeight: CGFloat = 150
    
    var timeinterval = TimeInterval()
    
    var item: MPMediaItem? {
        didSet {
            if let item = self.item {
                self.items.append(item)
            }
        }
    }
    var items: [MPMediaItem] = [] {
        didSet {
            player.setQueue(with: MPMediaItemCollection(items: items))
            self.tableView?.reloadData()
        }
    }
    var count: Int = 10
    deinit {
        removeObserver()
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
        self.timeinterval = (self.item?.playbackDuration)!
        self.setObserver()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateSeekBar(timer:)), userInfo: nil, repeats: true)
    }
    
    private func setObserver() {
        let eventCenter = MPRemoteCommandCenter.shared()
        let playObserve = eventCenter.observe(\.playCommand, options: [.new, .old]) { ( _, change) in
            if change.newValue == nil {
                return
            }
            self.updatePlaybackIcon(isPlay: true)
        }
        let pauseObserve = eventCenter.observe(\.pauseCommand, options: [.new, .old]) { (_, change) in
            if change.newValue == nil {
                return
            }
            self.updatePlaybackIcon(isPlay: false)
        }
        self.keyObservers.append(playObserve)
        self.keyObservers.append(pauseObserve)
    }
    private func removeObserver() {
        for keyValueObservation in keyObservers {
            keyValueObservation.invalidate()
        }
        keyObservers.removeAll()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createControllÇell(tableview: tableView, item: indexPath.item)
        default:
            return tableView.dequeueReusableCell(withIdentifier: "QueueCell", for: indexPath)
        }
    }
    private func createControllÇell(tableview: UITableView, item: Int) -> UITableViewCell {
        switch item {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ArtworkCell", for: artworkCellIndexPath) as? AudioArtworkCell else {
                fatalError()
            }
            cell.artworkImage = self.items[0].artwork?.image(at: MPMediaItem.albamJacketSize)
            return cell
        case 1:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ControllCell", for: controllerCellIndexPath) as? AudioControllerCell else {
                fatalError()
            }
            cell.maximumValue = Float(self.timeinterval)
            cell.isPlay = false
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
        guard let cell = tableView.cellForRow(at: self.controllerCellIndexPath) as? AudioControllerCell else {
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
            updatePlaybackIcon(isPlay: false)
        } else {
            player.prepareToPlay()
            player.play()
            updatePlaybackIcon(isPlay: true)
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
