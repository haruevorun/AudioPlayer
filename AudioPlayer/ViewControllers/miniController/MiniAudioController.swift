//
//  MiniAudioPlayer.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/08.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class MiniAudioController: UIView {

    @IBOutlet weak var contentView: UIVisualEffectView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playbackButton: UIButton!
    @IBOutlet weak var skipToNextButton: UIButton!
    
    let controller: MediaPlayerProtocol = AudioPlayer.shared
    let artwork: MediaPlayerArtworkProtocol = AudioPlayer.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.comminInit()
        self.artworkImageView.layer.cornerRadius = 10
        self.artworkImageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func comminInit() {
        Bundle.main.loadNibNamed("MiniAudioController", owner: self, options: nil)
        contentView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        contentView.frame = self.bounds
        self.addSubview(contentView)
        MPMusicPlayerApplicationController.applicationQueuePlayer.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeItem), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePlayback), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePlayback), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        MPMusicPlayerApplicationController.applicationQueuePlayer.endGeneratingPlaybackNotifications()
    }
    @objc private func didChangeItem() {
        self.artworkImageView.image = artwork.image ?? UIImage(named: "app_Icon")
        self.titleLabel.text = artwork.title
    }
    @objc private func didChangePlayback() {
        switch self.controller.isPlay {
        case true:
            self.playbackButton?.setImage(UIImage(named: "pause_icon"), for: .normal)
        case false:
            self.playbackButton?.setImage(UIImage(named: "play_icon"), for: .normal)
        }
    }
    @IBAction func playback(_ sender: Any) {
        switch self.controller.isPlay {
        case true:
            self.controller.pause()
        case false:
            self.controller.play()
        }
    }
    @IBAction func skipToNext(_ sender: Any) {
        self.controller.skipToNext()
    }
}
