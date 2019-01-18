//
//  AudioPlayer.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class AudioPlayViewController: UIViewController {
    
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
        }
    }
    var player = MPMusicPlayerController.applicationMusicPlayer
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    @IBAction func skip(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
    }
}
