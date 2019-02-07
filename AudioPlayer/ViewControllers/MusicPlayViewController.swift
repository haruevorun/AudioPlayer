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

class MusicPlayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var timer: Timer = Timer()
    
    let artworkCellIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    let controllerCellIndexPath: IndexPath = IndexPath(item: 1, section: 0)
    let artworkCellHeight: CGFloat = 500
    let controllerCellHeight: CGFloat = 250
    
    private let mediaPlayerOutPut: MediaPlayerOutputQueueProtocol = AudioPlayer.shared
    
    deinit {
        DebugUtil.log("MusicPlayer is deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AudioControllerCell", bundle: nil), forCellReuseIdentifier: "ControllCell")
        self.tableView.register(UINib(nibName: "AudioArtworkCell", bundle: nil), forCellReuseIdentifier: "ArtworkCell")
        self.tableView.register(UINib(nibName: "AudioQueueCell", bundle: nil), forCellReuseIdentifier: "QueueCell")
        self.tableView.register(UINib(nibName: "AudioQueueSectionHeader", bundle: nil), forCellReuseIdentifier: "QueueHeader")
        NotificationCenter.default.addObserver(self, selector: #selector(enterForground), name: NSNotification.Name.NSExtensionHostWillEnterForeground, object: nil)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    @objc private func enterForground() {
        self.tableView.reloadData()
    }
}
extension MusicPlayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return false
        default:
            return true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

extension MusicPlayViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return self.mediaPlayerOutPut.queueCount
            //return queue.count
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
            cell.title = self.mediaPlayerOutPut.queue[indexPath.item].title
            cell.artworkImage = self.mediaPlayerOutPut.queue[indexPath.item].artwork?.image(at: MPMediaItem.albamJacketThumbnailSize)
            cell.artist = self.mediaPlayerOutPut.queue[indexPath.item].artist
            return cell
        }
    }
    private func createControllÇell(tableview: UITableView, item: Int) -> UITableViewCell {
        switch item {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ArtworkCell", for: artworkCellIndexPath) as? AudioArtworkCell else {
                fatalError()
            }
            return cell
        case 1:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ControllCell", for: controllerCellIndexPath) as? AudioControllerCell else {
                fatalError()
            }
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
}
