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
    
    var timer = Timer()
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
    var timeinterval = TimeInterval()
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artworkView.image = item?.artwork?.image(at: CGSize(width: 300, height: 300))
        self.timeinterval = (self.item?.playbackDuration)!
        self.timeSlider.maximumValue = Float(self.timeinterval)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateslider), userInfo: nil, repeats: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    @objc func updateslider(){
        self.timeSlider.setValue(Float(self.player.currentPlaybackTime), animated: true)
    }
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    @IBAction func skip(_ sender: Any) {
        player.skipToNextItem()
    }
    @IBAction func back(_ sender: Any) {
        player.skipToBeginning()
    }
    @IBAction func changeValue(_ sender: UISlider) {
        player.currentPlaybackTime = TimeInterval(sender.value)
    }
}
