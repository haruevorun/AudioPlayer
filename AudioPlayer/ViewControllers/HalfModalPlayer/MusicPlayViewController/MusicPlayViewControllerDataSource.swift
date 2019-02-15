//
//  MusicPlayViewControllerDataSource.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/15.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class MusicPlayViewControllerDataSource: NSObject, UITableViewDataSource {
    
    private var playerOutPut: MediaPlayerOutputQueueProtocol = AudioPlayer.shared
    
    override init() {
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            ///ArtworkとController
            return 2
        default:
            return self.playerOutPut.queue.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createControlCell(tableview: tableView, item: indexPath.item)
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QueueCell", for: indexPath) as? AudioQueueCell else {
                fatalError()
            }
            cell.title = self.playerOutPut.queue[indexPath.item].title
            cell.artworkImage = self.playerOutPut.queue[indexPath.item].artwork?.image(at: MPMediaItem.albamJacketThumbnailSize)
            cell.artist = self.playerOutPut.queue[indexPath.item].artist
            return cell
        }
    }
    private func createControlCell(tableview: UITableView, item: Int) -> UITableViewCell {
        switch item {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ArtworkCell", for: IndexPath(item: 0, section: 0)) as? AudioArtworkCell else {
                fatalError()
            }
            return cell
        case 1:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "ControlCell", for: IndexPath(item: 1, section: 0)) as? AudioControllerCell else {
                fatalError()
            }
            return cell
        default:
            fatalError()
        }
    }
}
