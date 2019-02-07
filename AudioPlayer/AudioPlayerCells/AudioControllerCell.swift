//
//  AudioControllerCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AudioControllerCell: UITableViewCell {

    @IBOutlet private weak var remainingTimeLabel: UILabel!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var seekbar: UISlider!
    @IBOutlet private weak var playbackButton: UIButton!
    @IBOutlet private weak var skipNextButton: UIButton!
    @IBOutlet private weak var skipPreviousButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    private var timer: Timer = Timer()
    private var playerController: MediaPlayerProtocol = AudioPlayer.shared
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer.invalidate()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        MPMusicPlayerApplicationController.applicationQueuePlayer.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(changePlaybackState), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        MPMusicPlayerApplicationController.applicationQueuePlayer.endGeneratingPlaybackNotifications()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
        self.seekbar.maximumValue = Float(playerController.maximumMediaItemDuration)
    }
    
    @IBAction func playback(_ sender: Any) {
        if self.playerController.isPlay {
            self.playerController.pause()
        } else {
            self.playerController.play()
        }
    }
    @IBAction func skip(_ sender: Any) {
        self.playerController.skipToNext()
    }
    @IBAction func backToBeginning(_ sender: Any) {
        self.playerController.seek(time: 0)
    }
    @IBAction func seek(_ sender: UISlider) {
        let time = Double(sender.value)
        self.playerController.seek(time: time)
    }
    @IBAction func shuffle(_ sender: Any) {
        
    }
    @objc private func updateCurrentTime() {
        self.seekbar.maximumValue = Float(self.playerController.maximumMediaItemDuration)
        self.remainingTimeLabel.text = "-\(timeToString(time: Float(self.playerController.maximumMediaItemDuration - self.playerController.currentTime)))"
        self.currentTimeLabel.text = timeToString(time: Float(self.playerController.currentTime))
        self.seekbar.value = Float(self.playerController.currentTime)
    }
    @objc private func changePlaybackState() {
        switch self.playerController.isPlay {
        case true:
            self.playbackButton.setImage(UIImage(named: "pause_icon"), for: .normal)
        case false:
            self.playbackButton.setImage(UIImage(named: "play_icon"), for: .normal)
        }
    }
    private func timeToString(time: Float) -> String {
        let second: Int
        let minute: Int
        second = Int(time) % 60
        minute = Int(time) / 60
        return "\(minute):\(NSString(format: "%02d", second))"
    }
}
